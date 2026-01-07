require_relative 'base_model'

class BookGenre < BaseModel
  set_dataset :books_genres
  
  many_to_one :book, key: :book_id
  many_to_one :genre, key: :genre_id
  
  def validate
    super
    validates_presence [:book_id, :genre_id]
    validates_unique [:book_id, :genre_id]
  end
end