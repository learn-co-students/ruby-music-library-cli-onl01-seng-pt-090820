class Song 
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist
    @genre = genre
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
  
  def self.create(song)
    new_song = self.new(song)
    new_song.save
    new_song
  end 
  
  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end
end