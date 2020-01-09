require 'pry'
class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs 

  def slug
   artist_no_slug = self.name.gsub(/[^0-9A-Za-z\s*]/, '')
   artist_no_slug.gsub(" ","-").downcase
  end

  def self.find_by_slug(snail)
    self.all.select do |artist|
      artist.slug == snail 
    end.first
  end

end

#