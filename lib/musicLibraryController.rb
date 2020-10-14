require 'pry'

class MusicLibraryController 
  
  attr_accessor :path
  
  def initialize(path = './db/mp3s')
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
    loop do
      gets.chomp
      if gets.chomp == 'exit'
        break
      end
    end
  end
  
  def list_songs
    alphabatized = Song.all.sort_by(&:name)
    alphabatized.each.with_index(1) do |song, index| 
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists 
    alphabatized = Artist.all.sort_by(&:name)
    alphabatized.each.with_index(1) do |artist, index| 
      puts "#{index}. #{artist.name}"
    end
  end
  
  def list_genres 
    alphabatized = Genre.all.sort_by(&:name)
    alphabatized.each.with_index(1) do |genre, index| 
      puts "#{index}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    if Artist.find_by_name(artist_name)
      artist = Artist.find_by_name(artist_name)
      alphabatized_artist_songs = artist.songs.sort
        binding.pry
      alphabatized_artist_songs.each.with_index(1) do |song, index| 
        puts "#{index}. #{song}"
      end
    else 
      "There is no artist by that name in music library"
    end
  end
  
end