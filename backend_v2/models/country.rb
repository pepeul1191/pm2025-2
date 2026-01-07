require_relative 'base_model'

class Country < BaseModel
  set_dataset :countries
  
  one_to_many :users, key: :country_id
  
  def validate
    super
    validates_presence :name
    validates_max_length 30, :name
    validates_max_length 40, :male_demonym
    validates_max_length 40, :female_demonym
  end
end