require_relative 'base_model'

class Author < BaseModel
    set_dataset :authors
    many_to_many :books, join_table: :books_authors
  end