class Artist
    attr_accessor :name
    extend Concerns::Findable
    extend Memorable::ClassMethods
    include Memorable::InstanceMethods
    
    @@all = []

    # def initialize(name)
    #     @name = name
    #     @songs = []
    # end

    def self.all
        @@all
    end

    # def save
    #     @@all << self
    # end

    # def self.create(name)
    #     new_artist = Artist.new(name)
    #     new_artist.save
    #     new_artist
    # end

    def add_song(song)
        if song.artist && !self.songs.include?(song)
            self.songs << song
        elsif !self.songs.include?(song)
            self.songs << song
            song.artist = self
        end
    end

    # def songs
    #     @songs
    # end

    def genres
        self.songs.collect {|song| song.genre}.uniq
    end
end