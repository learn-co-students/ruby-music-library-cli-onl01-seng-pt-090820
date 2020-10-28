require 'pry'

class Song
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
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
    tmp = Song.new(name)
    tmp
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  def find_by_name(name)
    self.all.detect { |i| i.name == name}
  end

  def self.find_or_create_by_name(name)
    if (self.find_by_name(name) != nil)
      return self.find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.new_from_filename(fileName)
    splt = fileName.split(" - ")
    fndArtist = Artist.find_or_create_by_name(splt[0])
    fndGenre = Genre.find_or_create_by_name(splt[2].split(".mp3").join)
    self.new(splt[1],fndArtist,fndGenre)
  end

  def self.create_from_filename(fileName)
    self.new_from_filename(fileName).save
  end
end
