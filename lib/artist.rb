require 'pry'

class Artist 
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end
  
  def self.all 
    @@all 
  end 
  
  def self.destroy_all 
    @@all.clear 
  end 
  
  def save 
    @@all << self 
  end
  
  def self.create(name) 
    Artist.new(name)
  end
  
  def add_song(song)
      song.artist = self if song.artist == nil
      @songs << song unless @songs.include?(song)
  end
  
  def genres 
    songs = Song.all.select {|song| song.artist == self} 
    songs.map {|song| song.genre}.uniq
  end
    
  
end