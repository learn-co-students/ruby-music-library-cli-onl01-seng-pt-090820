class Song 
  
  attr_accessor :name
  
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist
      self.artist=(artist)
    end
    if genre 
      self.genre=(genre)
    end
    @@all << self 
  end 
  
  def artist=(artist) 
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    if genre.songs.find {|song| song == self}
    else
      genre.songs << self
    end
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
    Song.new(name)
  end 
  
  def self.find_by_name(name)
    Song.all.find {|song| song.name == name} 
  end 
  
  def self.find_or_create_by_name(name) 
    if yo = self.find_by_name(name)
      yo
    else 
      self.create(name)
    end
  end
  
  def self.new_from_filename(filename)
    song = filename.split(" - ")
    mp3 = song[2].split(".")
    # binding.pry
    artist = Artist.find_or_create_by_name(song[0])
    genre = Genre.find_or_create_by_name(mp3[0])
    Song.new(song[1], artist, genre)
  end
  
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end
  
end