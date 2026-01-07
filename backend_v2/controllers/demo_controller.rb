require 'sinatra/base'
require_relative '../config/database'

class DemoController < ApplicationController
  # Ruta principal
  get '/demo' do
    erb :demo
  end
end