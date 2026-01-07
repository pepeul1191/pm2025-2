require_relative 'base_model'

class Book < BaseModel
    set_dataset :books
    
    # Relaciones
    many_to_one :publisher
    many_to_many :authors, join_table: :books_authors
    many_to_many :genres, join_table: :books_genres
    #one_to_many :reviews
  end