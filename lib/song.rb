class Song
    attr_accessor :name
    attr_reader :artist, :genre


    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        self.artist = artist if artist
        self.genre = genre if genre
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
        instance = Song.new(name)
        instance.save
        instance
    end

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre 
        if !genre.songs.include?(self)
        genre.songs << self 
        end
      end

    def self.find_by_name(name)
        @@all.detect do |song|
            song.name == name
        end
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
      end

end