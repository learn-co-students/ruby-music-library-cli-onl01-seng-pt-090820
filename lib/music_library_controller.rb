require 'pry'
require_relative "../config/environment.rb"

class MusicLibraryController
  attr_accessor :path 

  def initialize(path = "./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
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
      
      if user_input == "list songs"
        list_songs
      elsif user_input == "list artists"
        list_artists
      elsif user_input == "list genres"
        list_genres
      elsif user_input == "list artist"
        list_songs_by_artist
      elsif user_input == "list genre"
        list_songs_by_genre
      elsif user_input == "play song"
        play_song
      elsif user_input != "exit"
        call
    end
  end
  
  def list_songs
    ordered_list_song = Song.all.sort {|song1, song2| song1.name <=> song2.name}
    ordered_list_song.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    ordered_list_artists = Artist.all.sort {|artist1, artist2| artist1.name <=> artist2.name}
    ordered_list_artists.each.with_index(1) do |artist, index|
        puts "#{index}. #{artist.name}"
    end
  end
  
  def list_genres
    ordered_list_genres = Genre.all.sort {|genre1, genre2| genre1.name <=> genre2.name}
    ordered_list_genres.each.with_index(1) do |genre, index|
        puts "#{index}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip
    if Artist.find_by_name(user_input)
      list = Artist.find_by_name(user_input).songs.sort {|song1, song2| song1.name <=> song2.name}
      list.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
   def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip
    if Genre.find_by_name(user_input)
      list = Genre.find_by_name(user_input).songs.sort {|song1, song2| song1.name <=> song2.name}
      list.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    user_index = gets.strip.to_i - 1
    
    if user_index.between?(0, Song.all.length - 1)
        ordered_list_song = Song.all.sort {|song1, song2| song1.name <=> song2.name}
        user_song = ordered_list_song[user_index]
            puts "Playing #{user_song.name} by #{user_song.artist.name}"
    end
  end

end