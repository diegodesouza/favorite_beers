require 'sinatra'
require 'shotgun'
require 'pry'
require 'csv'

def read_beers_from(filename)

end

get '/beers' do
  @beers = read_beers_from('beers.csv')
  erb :'beers/index'
end
