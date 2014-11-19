require 'sinatra'
require 'shotgun'
require 'pry'
require 'csv'

def read_beers_from(filename)
  beers = []

  CSV.foreach(filename, headers: true) do |row|
    beers << {
      name: row['name'],
      description: row['description']
    }
  end

  beers
end

get '/beers' do
  @beers = read_beers_from('beers.csv')
  erb :'beers/index'
end
