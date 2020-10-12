class Song
    attr_accessor :name, :artist, :genre
    
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist 
        self.genre = genre if genre 
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
        Song.new(name)
        self
    end

    def artist=(artist)
        @artist = artist 
        artist.add_song(self) if !artist.songs.include?(self)
     end

     def genre=(genre)
        @genre = genre
        genre.songs << self if !genre.songs.include?(self)
     end


     def self.find_by_name(name)
        self.all.find do |song| 
           if song.name == name
            return self
           else
            nil
           end
        end
    end
  
     def self.find_or_create_by_name(name)
        if self.find_by_name(name) == nil
            Song.create(name)
        else
            self
        end
        #binding.pry
     end
  
     def self.new_from_filename(file)
        #binding.pry
        art = Artist.find_or_create_by_name(file.split(" - ")[0])
        name = file.split(" - ")[1]
        genre = Genre.find_or_create_by_name(file.split(" - ")[2].split(".")[0])
        song = Song.new(name, art, genre)
        song
     end
  
     def self.create_from_filename(file)
        self.new_from_filename(file)
     end
  

end