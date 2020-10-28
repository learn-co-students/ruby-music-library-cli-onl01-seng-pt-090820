class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    self.save
  end

  def save #stores instance of self into array
    @@all << self
  end

  def self.all #displays all stored instances of Artist class
    @@all
  end

  def self.destroy_all #clears all of the stored instnaces classes
    @@all.clear
  end

  def self.create(name)
    tmp = Artist.new(name)
    tmp
  end

  def songs
    @songs
  end

  def add_song(song)
    if(song.artist != self)
      song.artist = self
    end
    if (!songs.include?(song))
      songs << song
    end
  end

  def genres
    gCollection = songs.map { |e| e.genre }.uniq
    gCollection
  end
end
