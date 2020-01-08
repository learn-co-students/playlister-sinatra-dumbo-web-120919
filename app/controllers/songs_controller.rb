require 'pry'
class SongsController < ApplicationController

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

  post '/songs' do 
    new_genres = params[:genres].map do |genre_id|
      Genre.find(genre_id.to_i)
    end
    Song.create(name: params[:name], artist_id: Artist.find_or_create_by(name: params[:artist_id]), genres: new_genres)
    redirect to '/songs'
  end
end
