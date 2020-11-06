class Artist
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def add_song(song)
    if !self.songs.include?(song)
      @songs << song
    end
    if !song.artist
      song.artist = self
    end
  end

  def genres
    @genre_array = []
    @songs.each do |song|
      if @genre_array.include?(song.genre)
        nil
      else
        @genre_array << song.genre
      end
    end
    @genre_array
  end

end
