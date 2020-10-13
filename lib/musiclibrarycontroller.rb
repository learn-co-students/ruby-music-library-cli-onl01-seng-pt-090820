class MusicLibraryController
    attr_reader :library
    def initialize(path = "./db/mp3s")
        # @library = MusicImporter.new(path).import                 #old attempt
        MusicImporter.new(path).import                              #second_attempt

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
            case user_input
            when "list songs"
                self.list_songs
            when "list artists"
                self.list_artists
            when "list genres"
                self.list_genres
            when "list artist"
                self.list_songs_by_artist
            when "list genre"
                self.list_songs_by_genre
            when "play song"
                self.play_song
            end
            call unless user_input == "exit"
    end

    # def list_songs        #old attempt
    #     # binding.pry
    #     filename_array = self.library.collect {|filename| filename.gsub(".mp3","")}
    #     filename_nested_array = filename_array.collect {|song| song.split(" - ")}
    #     sorted_nested_array = filename_nested_array.sort_by {|song_array| song_array[1]}
    #     @sorted_library = sorted_nested_array.collect {|song_array| song_array.join(" - ")}
    #     @sorted_library.each_with_index {|item, i| puts "#{i+1}. #{item}"}
    # end

    def songs_by_name
        Song.all.sort_by {|song| song.name}
    end

    def list_songs      #2nd attempt
        songs_by_name.map.with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        artists_names_sorted = Artist.all.collect {|artist| artist.name}.sort
        artists_names_sorted.each_with_index {|artist_name, i| puts "#{i+1}. #{artist_name}"}
    end

    def list_genres
        genres_names_sorted = Genre.all.collect {|genre| genre.name}.sort
        genres_names_sorted.each_with_index {|genre_name, i| puts "#{i+1}. #{genre_name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_name = gets.strip
        if Artist.find_by_name(artist_name)
            artists_sorted_songs = songs_by_name.select {|song| song.artist.name == artist_name}
            artists_sorted_songs.each_with_index {|song,i| puts "#{i+1}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_name = gets.strip
        if Genre.find_by_name(genre_name)
            songs_with_genre = songs_by_name.select {|song| song.genre.name == genre_name}
            songs_with_genre.each_with_index {|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.strip.to_i
        if song_number.between?(1, songs_by_name.size)
            song_index = song_number - 1
            song_to_play = songs_by_name[song_index]
            puts "Playing #{song_to_play.name} by #{song_to_play.artist.name}"
        end 
    end
end