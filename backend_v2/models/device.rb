require_relative 'base_model'

class Device < BaseModel
  set_dataset :devices
  
  many_to_one :user, key: :user_id
  
  def validate
    super
    validates_presence [:brand, :type, :user_id]
    validates_max_length 30, :brand
    validates_max_length 30, :type
  end
end