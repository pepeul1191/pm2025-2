require_relative 'base_model'

class User < BaseModel
  set_dataset :users
  
  many_to_one :country, key: :country_id
  one_to_many :devices, key: :user_id
  one_to_many :reviews, key: :user_id
  
  def validate
    super
    '''
    validates_presence [:username, :password, :first_names, :last_names, :email]
    validates_unique :username, :email
    validates_max_length 30, :username
    validates_max_length 50, :first_names
    validates_max_length 50, :last_names
    validates_max_length 30, :email
    '''
  end

  def self.find_with_country_details(username, password)
    dataset = select(
      Sequel[:users][:id],
      Sequel[:users][:username],
      Sequel[:users][:first_names],
      Sequel[:users][:last_names],
      Sequel[:users][:email],
      Sequel[:users][:profile_picture],
      Sequel[:users][:sex],
      Sequel[:countries][:id].as(:country_id),
      Sequel[:countries][:name].as(:country_name),
      Sequel[:countries][:flag_image].as(:country_flag)
    )
    .join(:countries, id: :country_id)
    .where(username: username, password: password)
    
    # Convertir a hash para evitar el problema de métodos
    user_hash = dataset.first
    return nil unless user_hash
    
    # Crear una estructura de datos limpia
    {
      user: {
        id: user_hash[:id],
        username: user_hash[:username],
        first_names: user_hash[:first_names],
        last_names: user_hash[:last_names],
        email: user_hash[:email],
        profile_picture: user_hash[:profile_picture],
        sex: user_hash[:sex],
        country: {
          id: user_hash[:country_id],
          name: user_hash[:country_name],
          flag_image: user_hash[:country_flag]
        }
      }
    }
  end
end