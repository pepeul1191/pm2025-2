require 'sinatra/base'
require_relative '../config/database'

class FileController < ApplicationController
    post '/api/v1/files' do
        # Verificar que se envió un archivo
        if params[:file] && params[:file][:tempfile]
            file = params[:file]
            original_filename = file[:filename]
            tempfile = file[:tempfile]
          
            # Generar nuevo nombre con timestamp
            extension = File.extname(original_filename)
            new_filename = "#{Time.now.to_i}_#{SecureRandom.hex(8)}#{extension}"
          
            # Ruta de destino en la carpeta public/users

            public_dir = File.join(File.dirname(__FILE__), '..', 'public', 'users')
          
            # Asegurar que el directorio existe
            FileUtils.mkdir_p(public_dir)
          
            # Ruta completa del nuevo archivo
            destination_path = File.join(public_dir, new_filename)
          
            # Copiar el archivo temporal a la ubicación final
            FileUtils.cp(tempfile.path, destination_path)

            # Actualizar en la db la imagen de usuario usando el id del JWT
            user_id = @current_user['user']['id']
            user = User[user_id]
            
            unless user
                status 404
                return {
                    success: false,
                    message: "Usuario no encontrado",
                    data: nil,
                    error: "No se encontró el usuario con ID: #{id}"
                }.to_json
            end

            #user.profile_picture = "/users/#{new_filename}"
            user.set(profile_picture: "users/#{new_filename}")
            user.save
            # Respuesta exitosa
            content_type :json
            {
                success: true,
                message: 'Archivo subido exitosamente',
                data: {
                    original_filename: original_filename,
                    new_filename: new_filename,
                    path: "users/#{new_filename}"
                },
                error: nil
            }.to_json
          
        else
            # Error si no se envió archivo
            status 400
            content_type :json
            {
                success: false,
                error: 'No se proporcionó ningún archivo',
                data: nil,
                message: nil
            }.to_json
        end
    rescue => e
        # Manejo de errores
        status 500
        content_type :json
        puts e.backtrace
        {
            success: false,
            error: "Error al procesar el archivo: #{e.message}"
        }.to_json
    end
end