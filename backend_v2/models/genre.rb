require_relative 'base_model'

class Genre < BaseModel
  set_dataset :genres
  
  many_to_many :books, left_key: :genre_id, right_key: :book_id, join_table: :books_genres
  
  def validate
    super
    validates_presence :name
    validates_max_length 30, :name
    validates_unique :name
  end
end