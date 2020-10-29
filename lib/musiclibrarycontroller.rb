require 'pry'
class MusicLibraryController
  attr_reader :path
  def initialize(path = './db/mp3s')
    @path = path
    imptr = MusicImporter.new(@path).import
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

    while (input = gets.chomp) != "exit"
      case input
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
    end
  end

  def list_songs
    orgnized = Song.all.sort_by {|sng| sng.name}.uniq
    orgnized.each_with_index do |song,index|
      puts ((index + 1).to_s + ". " + song.artist.name + " - " + song.name + " - " + song.genre.name)
    end
  end

  def list_artists
    orgnized = Artist.all.sort_by { |artst| artst.name}
    orgnized.each_with_index do |artist, index|
      puts ((index +1 ).to_s + ". " + artist.name)
    end
  end

  def list_genres
    orgnized = Genre.all.sort_by { |gnre| gnre.name}
    orgnized.each_with_index do |genre,index|
      puts ((index +1).to_s + ". " + genre.name)
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(gets.chomp)
    if (artist != nil)
      tmp = artist.songs.sort_by { |songs| songs.name}
      tmp.each_with_index do |song, index|
        puts ((index + 1).to_s + ". " + song.name + " - " + song.genre.name)
      end
    else
      nil
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(gets.chomp)
    if (genre != nil)
      tmp = genre.songs.sort_by { |song| song.name}
      tmp.each_with_index do |songs, index|
        puts ((index + 1).to_s + ". " + songs.artist.name +  " - " + songs.name)
      end
    else
      nil
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    index = gets.chomp.to_i
    if (index > 1 && index <= 4)
      orgnized = Song.all.sort_by {|sng| sng.name}.uniq
      puts "Playing #{orgnized[index - 1].name} by #{orgnized[index - 1].artist.name}"
    else
      nil
    end
  end

end