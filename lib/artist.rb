class Artist
    attr_accessor :name
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        new_artist = Artist.new(name)
        new_artist.save
        new_artist
    end

    def add_song(song)
        if song.artist && !self.songs.include?(song)
            self.songs << song
        elsif !self.songs.include?(song)
            self.songs << song
            song.artist = self
        end
    end

    def songs
        @songs
    end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end
end