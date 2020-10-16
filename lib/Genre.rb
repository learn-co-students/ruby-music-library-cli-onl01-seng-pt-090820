require_relative 'concerns/findable.rb'

class Genre extend Concerns::Findable
    attr_accessor :name, :songs
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
    end

    def add_song(song)
        @songs << song
    end

    def artists
        artists = []
        songs.each do |song|
            if !artists.include?(song.artist)
                artists << song.artist
            end
        end
        artists
    end

end