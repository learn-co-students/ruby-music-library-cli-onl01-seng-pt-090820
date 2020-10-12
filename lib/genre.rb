require_relative "./concerns/findable.rb"

class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs, :genres
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save
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
        Genre.new(name)
        #self
    end

    def artists
        songs.collect{|s| s.artist}.uniq
    end

end