require 'pry'
require 'rack-flash'
class SongsController < ApplicationController
  enable :sessions 
  use Rack::Flash
  get '/songs' do
    @songs = Song.all 

    erb :"songs/index"
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end
  
  get '/songs/:slug/edit' do 
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :"songs/edit"
  end

  patch '/songs/:slug' do
    params.delete(:_method)
    #binding.pry
    new_genres = params[:genres].map do |genre_id|
      Genre.find(genre_id.to_i)
    end
    song = Song.find_by_slug(params[:slug])
    song.update(name: params[:name], genres: new_genres)
    slug = song.slug

    redirect to "/songs/#{song.slug}"
  end 
  
  
  post '/songs' do 
    new_genres = params[:genres].map do |genre_id|
      Genre.find(genre_id.to_i)
    end
    @song = Song.create(name: params[:name], artist_id: Artist.find_or_create_by(name: params[:artist_name].strip).id, genres: new_genres)
    flash[:message] = 'Successfully created song.'
    redirect to "/songs/#{@song.slug}"
  end

end
