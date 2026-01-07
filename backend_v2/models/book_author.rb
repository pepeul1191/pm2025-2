require_relative 'base_model'

class BookAuthor < BaseModel
  set_dataset :books_authors
  
  many_to_one :book, key: :book_id
  many_to_one :author, key: :author_id
  
  def validate
    super
    validates_presence [:book_id, :author_id]
    validates_unique [:book_id, :author_id]
  end
end