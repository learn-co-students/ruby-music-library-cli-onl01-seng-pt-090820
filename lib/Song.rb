require_relative 'concerns/findable.rb'

class Song extend Concerns::Findable
    attr_accessor :name, :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist=(artist)
        self.genre=(genre)
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end
    
    def self.create(name, artist = nil, genre = nil)
        song = Song.new(name, artist, genre)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        if artist != nil
            artist.add_song(self)
        end
    end

    def genre=(genre)
        @genre = genre
        if genre != nil && !genre.songs.include?(self)
            genre.add_song(self)
        end
    end

    def self.new_from_filename(filename)
        filename = filename.gsub('.mp3', '').split(' - ')        
        song = Song.create(filename[1],
        Artist.find_or_create_by_name(filename[0]),
        Genre.find_or_create_by_name(filename[2]))
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end


end