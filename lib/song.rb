class Song
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
  
  def self.destroy_all
    @@all = @@all.clear
  end
  
  def save 
    @@all << self
  end
  
  def self.create(name)
    instance = Song.new(name)
    instance.save
    instance
  end
  
  def artist=(artist)
    @artist = artist 
    @artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre 
    if !genre.songs.include?(self)
    genre.songs << self 
    end
  end
  
  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name 
    end 
  end
  
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  

  def self.new_from_filename(file)
    new_file = file.chomp(".mp3").split(" - ")
    new_song = new_file[1]
    new_artist = new_file[0]
    new_genre = new_file[2]
    song = self.find_or_create_by_name(new_song)
    song.artist = Artist.find_or_create_by_name(new_artist)
    song.genre = Genre.find_or_create_by_name(new_genre)
    song
  end
  
  def self.create_from_filename(file)
    self.new_from_filename(file)
  end
end