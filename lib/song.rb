class Song
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
 def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def save
    @@all << self
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(song_name)
    new_song = self.new(song_name)
    new_song.save
    new_song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if !genre.songs.include?(self)
      genre.songs << self
   end
  end
  
  def self.new_from_filename(filename)
    song_name = filename.split(" - ")[1]
    song = self.new(song_name)
    song.artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    song.genre = Genre.find_or_create_by_name(filename.split(" - ")[2].gsub(".mp3", ""))
    song
  end
  
  def self.create_from_filename(filename)
    new_song = self.new_from_filename(filename)
    new_song.save
  end
  
end
