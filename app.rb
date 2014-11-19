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

get '/beers/new' do
  erb :'beers/new'
end

post '/beers' do
  # params looks like this:
  # {"beer"=>{"name"=>"Pumpkinhead", "description"=>"Delicious!"}}

  # take the beer params from params hash
  name = params[:beer][:name]
  description = params[:beer][:description]

  # add the beer to the CSV
  CSV.open('beers.csv', 'a') do |csv|
    csv << [name, description]
  end

  # redirect the user to the index page
  redirect '/beers'
end




