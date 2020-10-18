require 'pry'

class Song

    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        new_song = self.new(name)
        new_song.save
        new_song
    end

    def self.find_by_name(song)
        self.all.detect{|song_name| song_name.name == song}
    end

    def self.find_or_create_by_name(song)
        self.find_by_name(song) || self.create(song)
    end

    def self.new_from_filename(file)
        song_parts = file.split(" - ")
        artist_name, song_name, genre_name = song_parts[0], song_parts[1],song_parts[2].gsub(".mp3", "")

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
       new_file = self.new_from_filename(filename)
       new_file.save
    end

end 