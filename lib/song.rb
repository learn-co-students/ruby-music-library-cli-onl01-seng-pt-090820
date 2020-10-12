require 'pry'
class Song
    attr_accessor :name, :artist, :genre
    
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        @artist = artist
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
end