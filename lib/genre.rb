class Genre
    
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

    def self.create(genre)
        new_genre = self.new(genre)
        new_genre.save
        new_genre
    end

    def artists
        artists = songs.collect {|artist_genre| artist_genre.artist}
        artists.uniq
    end

end 