class Genre
    attr_accessor :name
    
    @@all = []

    def initialize(name)
        @name = name
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
        new_genre = Genre.new(name)
        new_genre.save
        new_genre
    end
end