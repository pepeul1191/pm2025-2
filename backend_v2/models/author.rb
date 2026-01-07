require_relative 'base_model'

class Author < BaseModel
  set_dataset :authors
  
  many_to_many :books, left_key: :author_id, right_key: :book_id, join_table: :books_authors
  
  def validate
    super
    validates_presence :full_name
    validates_max_length 60, :full_name
  end
end