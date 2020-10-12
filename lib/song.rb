require 'pry'

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

    def self.new_from_filename(filename)
        # binding.pry
        song_array = filename.split(" - ").map {|song_element| song_element.gsub(".mp3","")}        
        song_artist = song_array[0]
        song_name = song_array[1]
        song_genre = song_array[2]
        new_song = self.find_or_create_by_name(song_name)
        new_song.artist = Artist.find_or_create_by_name(song_artist)
        new_song.genre = Genre.find_or_create_by_name(song_genre)
        new_song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end
end