require 'pry'

class Artist
    
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(artist)
        new_artist = self.new(artist)
        new_artist.save
        new_artist
    end

    def add_song(song)
        song.artist = self unless song.artist
        songs << song unless songs.include?(song)
    end

    def genres
        genres = songs.collect {|song_genres| song_genres.genre}
        genres.uniq
    end


end 