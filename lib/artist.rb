require_relative "./concerns/findable.rb"

class Artist
    extend Concerns::Findable

    attr_accessor :name, :songs
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def self.all
        @@all
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        if !self.songs.include?(song)
            self.songs << song
        end
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        Artist.new(name)
        #self
    end

    def genres
        songs.collect{|s| s.genre}.uniq
    end

end