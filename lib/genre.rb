class Genre
    attr_accessor :name
    attr_reader :songs
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

    # def self.destroy_all
    #     @@all.clear
    # end

    # def save
    #     @@all << self
    # end

    # def self.create(name)
    #     new_genre = Genre.new(name)
    #     new_genre.save
    #     new_genre
    # end

    # def songs
    #     @songs
    # end

    def artists
        self.songs.collect {|song| song.artist}.uniq
    end
end