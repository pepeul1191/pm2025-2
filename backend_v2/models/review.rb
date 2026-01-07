require_relative 'base_model'

class Review < BaseModel
  set_dataset :reviews
  
  many_to_one :user, key: :user_id
  many_to_one :book, key: :book_id
  
  def validate
    super
    validates_presence [:rating, :user_id, :book_id]
    validates_integer :rating
    validates_in_range 1..5, :rating
  end
end