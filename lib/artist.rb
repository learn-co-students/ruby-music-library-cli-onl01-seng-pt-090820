class Artist 
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
  
  def self.create(artist)
    new_artist = self.new(artist)
    new_artist.save
    new_artist
  end 
  
  def add_song(song)
    if !song.artist
      song.artist = self
      @songs << song
    end
  end

end