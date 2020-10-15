require 'pry'

class MusicLibraryController 
  
  attr_accessor :path
  
  def initialize(path = './db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end 
  
  def start 
    list_songs
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
        input = gets.chomp
        if input == 'exit'
          break
          elsif input == 'list songs'
            list_songs
          elsif input == 'list artists' 
            list_artists 
          elsif input == 'list genres'
            list_genres
          elsif input == 'list artist'
            list_songs_by_artist 
          elsif input == 'list genre'
            list_songs_by_genre
          elsif input == 'play song'
            play_song
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
      name = Artist.find_by_name(artist_name)
      alphabatized_artist_songs = name.songs.sort_by(&:name)
      alphabatized_artist_songs.each.with_index(1) do |song, index| 
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    else 
      "There is no artist by that name in music library"
    end
  end
  
  def list_songs_by_genre 
    puts "Please enter the name of a genre:"
    input_genre = gets.chomp 
    if Genre.find_by_name(input_genre)
      genre = Genre.find_by_name(input_genre)
      alphabatized_genre_songs = genre.songs.sort_by(&:name)
      alphabatized_genre_songs.each.with_index(1) do |song, index| 
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    else 
      "There is no artist by that name in music library"
    end
  end
  
  def play_song 
    puts "Which song number would you like to play?"
    song_index = gets.chomp.to_i - 1
    # binding.pry
    if song_index.between?(0, Song.all.length - 1)
      songs = Song.all.sort_by(&:name)
      song_i = songs[song_index]
      puts "Playing #{song_i.name} by #{song_i.artist.name}"
    end
  end 
  
  
end