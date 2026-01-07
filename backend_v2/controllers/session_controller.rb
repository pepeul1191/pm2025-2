require 'sinatra/base'
require_relative '../config/database'

class SessionController < ApplicationController
    post '/api/v2/sign-in' do
        content_type :json
        
        begin
            request_body = JSON.parse(request.body.read) rescue nil
        
            username = request_body['username']
            password = request_body['password']
            # INSERT INTO genres (name) VALUES (:name)
            user = User.find_with_country_details(username, password)

            unless user
                status 404
                return {
                    success: false,
                    message: "Usuario y/o contraseña",
                    data: nil,
                    error: "No se encontró al usuario"
                }.to_json
            end
            
            token = generate_token(user)

            status 201  # Created
            {
                success: true,
                message: "Usuario validado",
                data: {
                    user: user[:user],
                    tokens: {
                        biblioapp: token,
                        files: 'XDDDDDDDDDDDDDDDDDDDD'
                    },
                },
                error: nil
            }.to_json
        rescue => e
            puts e.backtrace.join("\n")
            status 500  # Internal Server Error
            {
                success: false,
                message: "Error al crear el género",
                data: nil,
                error: e.message
            }.to_json
        end
    end
end