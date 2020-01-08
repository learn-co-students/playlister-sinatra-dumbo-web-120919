class Song < ActiveRecord::Base
  has_many :song_genres
  has_many :genres, through: :song_genres
  belongs_to :artist

  def slug
    song_slug = self.name.gsub(/[^0-9A-Za-z\s*]/, '')
    song_slug.gsub(" ","-").downcase
   end
 
   def self.find_by_slug(slug_name)
     self.all.select do |song|
       song.slug == slug_name 
     end.first
   end

end