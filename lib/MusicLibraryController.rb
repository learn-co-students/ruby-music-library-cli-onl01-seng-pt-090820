require 'pry'

class MusicLibraryController

    def initialize(file_path = './db/mp3s')
        MusicImporter.new(file_path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list" + 
        " artist'."
        puts "To list all of the songs of a particular genre, enter 'list" + 
        " genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets
        case input
            when 'list songs'
                list_songs
            when 'list artists'
                list_artists
            when 'list genres'
                list_genres
            when 'list artist'
                list_songs_by_artist
            when 'list genre'
                list_songs_by_genre
            when 'play song'
                play_song
        end
        if input != 'exit'
            call
        end
    end

    def list_songs
        songs = Song.all.uniq.sort_by {|song| song.name}
        x = 1
        songs.each do |song|
            puts "#{x}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            x += 1
        end
    end

    def list_artists
        artists = Artist.all.uniq.sort_by {|artist| artist.name}
        x = 1
        artists.each do |artist|
            puts "#{x}. #{artist.name}"
            x += 1
        end
    end

    def list_genres
        genres = Genre.all.uniq.sort_by {|genre| genre.name}
        x = 1
        genres.each do |genre|
            puts "#{x}. #{genre.name}"
            x += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets
        artist = Artist.find_by_name(input)
        x = 1
        if artist != nil
            songs = artist.songs.uniq.sort_by {|song| song.name}
            songs.each do |song|
                puts "#{x}. #{song.name} - #{song.genre.name}"
                x += 1
            end
        end        
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets
        genre = Genre.find_by_name(input)
        x = 1
        if genre != nil
            songs = genre.songs.uniq.sort_by {|song| song.name}
            songs.each do |song|
                puts "#{x}. #{song.artist.name} - #{song.name}"
                x += 1
            end
        end        
    end

    def play_song
        songs = Song.all.uniq.sort_by {|song| song.name}
        puts "Which song number would you like to play?"
        input = gets
        input = input.to_i
        if input.between?(1, songs.length + 1)
            if songs[input - 1].class == Song
                puts "Playing #{songs[input - 1].name} by #{songs[input - 1].artist.name}"
            end
        end
    end

end