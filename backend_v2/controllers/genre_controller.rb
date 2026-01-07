require 'sinatra/base'
require_relative '../config/database'

class GenreController < ApplicationController
    get '/api/v1/genres' do
        # SELECT * FROM genres;
        Genre.all.to_json
    end

    get '/api/v2/genres' do
        content_type :json
        begin
            {
                success: true,
                message: "Listado de géneros OK",
                data: Genre.all,
                error: nil
            }.to_json
        rescue => e
            puts e.backtrace.join("\n")
            status 500  # Internal Server Error
            {
                success: false,
                message: "Error al obtener los géneros",
                data: [],
                error: e.message
            }.to_json
        end
    end

    get '/api/v1/genres/:id' do
        Genre[params[:id]].to_json
    end

    get '/api/v2/genres/:id' do
        content_type :json
        id = params[:id]
        
        begin
            # Buscar el género por ID
            genre = Genre[id] # SELECT * FROM genres WHERE id = :id
            if genre
                # Género encontrado
                {
                    success: true,
                    message: "Género encontrado",
                    data: genre.values,
                    error: nil
                }.to_json
            else
                # Género no encontrado
                status 404  # Not Found
                {
                    success: false,
                    message: "Género no encontrado",
                    data: nil,
                    error: "No se encontró el género con ID: #{id}"
                }.to_json
            end
            
        rescue => e
            puts e.backtrace.join("\n")
            status 500  # Internal Server Error
            {
                success: false,
                message: "Error al buscar el género",
                data: nil,
                error: e.message
            }.to_json
        end
    end

    post '/api/v2/genres' do
        content_type :json
        
        begin
            request_body = JSON.parse(request.body.read) rescue nil
        
            name = request_body['name']
            # INSERT INTO genres (name) VALUES (:name)
            genre = Genre.create(name: name.strip)
            
            status 201  # Created
            {
                success: true,
                message: "Género creado exitosamente",
                data: genre.values,
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

    put '/api/v2/genres/:id' do
        content_type :json
        
        begin
            id = params[:id]
            request_body = JSON.parse(request.body.read) rescue nil
        
            name = request_body['name']
    
            # Buscar el género a actualizar
            genre = Genre[id]
            
            unless genre
                status 404
                return {
                    success: false,
                    message: "Género no encontrado",
                    data: nil,
                    error: "No se encontró el género con ID: #{id}"
                }.to_json
            end
    
            # Actualizar el género
            # UPDATE genres SET name = :name WHERE id = :id
            genre.update(name: name.strip)
            
            {
                success: true,
                message: "Género actualizado exitosamente",
                data: genre.values,
                error: nil
            }.to_json
            
        rescue => e
            puts e.backtrace.join("\n")
            status 500
            {
                success: false,
                message: "Error al actualizar el género",
                data: nil,
                error: e.message
            }.to_json
        end
    end

    delete '/api/v2/genres/:id' do
        content_type :json
        id = params[:id]
        
        begin
            # Buscar el género a eliminar
            genre = Genre[id]
            
            unless genre
                status 404
                return {
                    success: false,
                    message: "Género no encontrado",
                    data: nil,
                    error: "No se encontró el género con ID: #{id}"
                }.to_json
            end
    
            # Eliminar el género
            # DELETE FROM genres WHERE id = :id
            genre.delete
            
            {
                success: true,
                message: "Género eliminado exitosamente",
                data: { id: id },
                error: nil
            }.to_json
            
        rescue => e
            puts e.backtrace.join("\n")
            status 500
            {
                success: false,
                message: "Error al eliminar el género",
                data: nil,
                error: e.message
            }.to_json
        end
    end
end