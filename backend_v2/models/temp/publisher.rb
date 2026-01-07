require_relative 'base_model'

class Publisher < BaseModel
    set_dataset :publishers
    one_to_many :books
  end