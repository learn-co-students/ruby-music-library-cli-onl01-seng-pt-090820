class Genre
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
        instance = Genre.new(name)
        instance.save
        instance
    end

    def artists
        artists = []
        songs.map do |song|
            artists << song.artist
        end
        artists.uniq
    end
    
    
    
   
end