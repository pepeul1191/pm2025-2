require 'sinatra/base'
require 'jwt'
require_relative '../helpers/application_helper'
require_relative '../config/database'

class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers

  configure do
    set :views, File.expand_path('../views', __dir__)
    set :public_folder, File.expand_path('../public', __dir__)
    set :bind, '0.0.0.0'
    set :port, 5000
  end
  
  configure :development do
    set :logging, true
    set :dump_errors, true
    set :show_exceptions, true
    DB.loggers << Logger.new($stdout)
  end

  # Cargar modelos (se pueden cargar individualmente según sea necesario)
  Dir[File.expand_path('../models/*.rb', __dir__)].each { |file| require file }

  # Configuración del JWT
  set :jwt_secret, ENV['JWT_SECRET'] || 'tu_clave_secreta_super_segura'
  # Opcional: Tiempo de expiración del token
  set :jwt_expiration, 24 * 60 * 60 # 24 horas en segundos

  BEFORE_FILTER_EXCLUDED_ROUTES = [
    '/api/v2/sign-in', 
  ].freeze

  before '/api/*' do
    unless BEFORE_FILTER_EXCLUDED_ROUTES.include?(request.path)
      token = request.env['HTTP_AUTHORIZATION']&.gsub(/^Bearer /, '')
    
      unless token
        content_type :json
        halt 401, {
          success: false,
          message: "Token requerido",
          data: nil,
          error: "No está enviando el token"
        }.to_json
      end

      begin
        decoded_token = JWT.decode(token, settings.jwt_secret, true, { algorithm: 'HS256' })
        @current_user = decoded_token[0]
      rescue JWT::DecodeError
        content_type :json
        halt 401, {
          success: false,
          message: "Token inválido",
          data: nil,
          error: "No se pudo decodificar el token recibido."
        }.to_json
      rescue JWT::ExpiredSignature
        content_type :json
        halt 401, {
          success: false,
          message: "Token expirado",
          data: nil,
          error: "Ya expiró el tiempo de vida del token"
        }.to_json
      end
    end
  end

  # Ruta principal
  get '/' do
    erb :index
  end

  get '/about' do
    erb :about
  end

  # Método helper para establecer el título de página
  def page_title(title = "Aplicación Sinatra")
    @page_title = title
  end

  not_found do
    # Si la URL comienza con /api, manejamos el error de manera personalizada
    if request.path_info.start_with?('/api')
      status 404
      content_type :json
      {
        success: false,
        message: "Recurso no encontrado",
        data: nil,
        error: ""
      }.to_json
    else
      # Comportamiento estándar para otros casos
      'Página no encontrada'
    end
  end

  # Ejecutar la aplicación si este archivo es ejecutado directamente
  run! if app_file == $0
end