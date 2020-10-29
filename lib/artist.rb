class Artist
    extend Concerns::Findable


    attr_accessor :name
    attr_reader :songs


    @@all = []

    def initialize(name)
        @name = name 
        @songs = []
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
        instance = Artist.new(name)
        instance.save
        instance
    end

    def add_song(song)
        song.artist = self if song.artist == nil
        self.songs << song unless @songs.include?(song)
      end
      
    def genres
        genres = []
        songs.map do |song|
            genres << song.genre
        end
        genres.uniq
    end
        
end