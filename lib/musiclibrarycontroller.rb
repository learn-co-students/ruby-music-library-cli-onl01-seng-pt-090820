class MusicLibraryController
    attr_reader :library
    def initialize(path = "./db/mp3s")
        @library = MusicImporter.new(path).import                 #old attempt
        # MusicImporter.new(path).import                              #second_attempt

    end

    def call
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            user_input = gets.strip
            call unless user_input == "exit"
    end

    def list_songs        #old attempt
        # binding.pry
        filename_array = self.library.collect {|filename| filename.gsub(".mp3","")}
        filename_nested_array = filename_array.collect {|song| song.split(" - ")}
        sorted_nested_array = filename_nested_array.sort_by {|song_array| song_array[1]}
        sorted_library = sorted_nested_array.collect {|song_array| song_array.join(" - ")}
        sorted_library.each_with_index {|item, i| puts "#{i+1}. #{item}"}
    end

    # def list_songs      #2nd attempt
    #     # binding.pry
    #     songs_by_name = Song.all.sort_by {|song| song.name}
    #     songs_by_name.each_with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    # end

    
end