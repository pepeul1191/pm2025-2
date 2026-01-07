# models/genre.rb
require_relative 'base_model'

class Genre < BaseModel
  set_dataset :genres
  many_to_many :books, join_table: :books_genres
end