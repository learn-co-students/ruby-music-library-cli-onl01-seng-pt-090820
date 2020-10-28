class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(genre)
    @name = genre
    @songs = []
    self.save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    tmp = Genre.new(name)
    tmp
  end

  def songs
    @songs
  end

  def add_song(song)
    if (!songs.detect { |i| i == song})
      self.songs << song
    end
  end

  def artists
    aCollection = songs.map { |e| e.artist  }.uniq
    aCollection
  end
end
