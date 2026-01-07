require 'sequel'
require 'logger'

DB = Sequel.sqlite('db/app.db')

# Configuración de logging para desarrollo
DB.loggers << Logger.new($stdout) if defined?(Sinatra::Base) && Sinatra::Base.development?