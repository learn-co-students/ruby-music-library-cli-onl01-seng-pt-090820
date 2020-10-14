require 'pry'

class MusicLibraryController
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
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
    
    input = gets.strip
    
    if input != "exit"
      call
    end
    
  end
  
  def list_songs
    ordered_list = Song.all.sort {|a, b| a.name <=> b.name}
    ordered_list.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    ordered_list = Artist.all.sort {|a, b| a.name <=> b.name}
    ordered_list.each.with_index(1) do |artist, index|
        puts "#{index}. #{artist.name}"
    end
  end
  
  def list_genres
    ordered_list = Genre.all.sort {|a, b| a.name <=> b.name}
    ordered_list.each.with_index(1) do |genre, index|
        puts "#{index}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip.downcase
    
    Artist.all.find do |artist| 
      if artist.name.downcase == input
        sorted_songs = artist.songs.sort{|a, b| a.name <=> b.name}
        sorted_songs.each.with_index(1) do |song, index|
          puts "#{index}. #{song.name} - #{song.genre.name}"
        end
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip.downcase
    
    Genre.all.find do |genre| 
      if genre.name.downcase == input
        sorted_songs = genre.songs.sort{|a, b| a.name <=> b.name}
        sorted_songs.each.with_index(1) do |song, index|
          puts "#{index}. #{song.artist.name} - #{song.name}"
        end
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    index = gets.strip.to_i
    
    if index.between?(0, Song.all.length - 1)
      binding.pry
      puts "Playing song"
    end
    
    
  end
  
end