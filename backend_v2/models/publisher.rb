require_relative 'base_model'

class Publisher < BaseModel
  set_dataset :publishers
  
  one_to_many :books, key: :publisher_id
  
  def validate
    super
    validates_presence :name
    validates_max_length 50, :name
  end
end