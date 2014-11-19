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

def save_beer(filename, name, description)
  CSV.open(filename, 'a') do |csv|
    csv << [name, description]
  end
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
  if !params[:beer][:name].empty?
    name = params[:beer][:name]
    description = params[:beer][:description]

    # add the beer to the CSV
    save_beer('beers.csv', name, description)

    # redirect the user to the index page
    redirect '/beers'
  else
    @error_message = "You must enter a name."
    erb :'beers/new'
  end
end




