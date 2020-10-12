require 'pry'
class Song
    attr_accessor :name
    attr_reader :genre, :artist
    
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist
        @genre = genre
    end

    def self.all
        @@all.dup.freeze
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        new_song = Song.new(name)
        new_song.save
        new_song
    end

    def artist=(artist)
        if artist && !artist.songs.include?(self)
            @artist = artist
            artist.add_song(self)
        elsif artist
            @artist = artist
        end
    end
end