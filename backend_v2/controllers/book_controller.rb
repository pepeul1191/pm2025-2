require 'sinatra/base'
require_relative '../config/database'

class BookController < ApplicationController
    get '/api/v1/books' do
        # SELECT * FROM books;
        Book.all.to_json
    end

    get '/api/v2/books' do
        content_type :json
        begin
            {
                success: true,
                message: "Listado de libros OK",
                data: Book.all,
                error: nil
            }.to_json
        rescue => e
            puts e.backtrace.join("\n")
            status 500  # Internal Server Error
            {
                success: false,
                message: "Error al obtener los libros",
                data: [],
                error: e.message
            }.to_json
        end
    end

    get '/api/v3/books' do
        content_type :json
        begin
            if params[:genres_ids] # filtrar por generos
                genres_ids = params[:genres_ids].split(',').map(&:to_i)
                
                # Obtener los IDs de libros que tienen los géneros solicitados
                book_ids = DB[:books_genres]
                    .where(genre_id: genres_ids)
                    .select(:book_id)
                    .distinct
                    .map(:book_id)

                # Cargar los libros con todas las asociaciones usando los IDs filtrados
                books = Book.with_all_associations
                    .where(id: book_ids)
                    .all
            else # no hay filtros
                books = Book.with_all_associations.all
            end
      
            {
                success: true,
                message: "Listado de libros OK",
                data: books.map(&:to_custom_json),
                error: nil
            }.to_json
        rescue => e
            puts e.backtrace.join("\n")
            status 500  # Internal Server Error
            {
                success: false,
                message: "Error al obtener los libros",
                data: [],
                error: e.message
            }.to_json
        end
    end
end