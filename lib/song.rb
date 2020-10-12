class Song
    attr_accessor :name
    attr_reader :genre, :artist
    extend Concerns::Findable
    extend Memorable::ClassMethods
    include Memorable::InstanceMethods
    
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist
        self.genre = genre
    end

    def self.all
        @@all
    end

    # def self.destroy_all
    #     @@all.clear
    # end

    # def save
    #     @@all << self
    # end

    # def self.create(name)
    #     new_song = Song.new(name)
    #     new_song.save
    #     new_song
    # end

    def artist=(artist)
        if artist && !artist.songs.include?(self)
            @artist = artist
            artist.add_song(self)
        elsif artist
            @artist = artist
        end
    end

    def genre=(genre)
        if genre
            @genre = genre
            genre.songs << self unless genre.songs.include?(self)
        end
    end

    # def self.find_by_name(name)
    #     self.all.find {|song| song.name == name}
    # end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end

end