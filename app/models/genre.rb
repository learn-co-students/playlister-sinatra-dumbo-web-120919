class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    genre_no_slug = self.name.gsub(/[^0-9A-Za-z\s*]/, '')
    genre_no_slug.gsub(" ","-").downcase
   end
 
   def self.find_by_slug(snail)
     self.all.select do |genre|
       genre.slug == snail 
     end.first
   end

end