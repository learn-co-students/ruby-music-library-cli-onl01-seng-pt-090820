class Genre

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
    new_genre = self.new(name)
    new_genre.save
    new_genre
  end

  def add_song(song)
    if !self.songs.include?(song)
      @songs << song
    end
    if !song.genre
      song.genre = self
    end
  end

  def artists
    @artist_array = []
    @songs.each do |song|
      if @artist_array.include?(song.artist)
        nil
      else
        @artist_array << song.artist
      end
    end
    @artist_array
  end

end
