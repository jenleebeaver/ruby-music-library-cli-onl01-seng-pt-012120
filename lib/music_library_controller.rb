
class MusicLibraryController

  def initialize(path = "./db/mp3s") #accepts path
    MusicImporter.new(path).import #instantiates a music importer object that is used to import songs from a specified library
  end

  def call
    input = ""

    while input != "exit" #creating input values
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
      #gets returns input values and strip removes whitespace

      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
        end
      end
    end

    def list_songs #looping through song names and putting in numbered list artist name, song name, and genre name
      Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
        puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
      end
    end

    def list_artists #looping through artists names and putting in numbered list
      Artist.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |a, i|
        puts "#{i}. #{a.name}"
      end
    end

    def list_genres #looping through genre names and putting in numbered list
      Genre.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |g, i|
        puts "#{i}. #{g.name}"
      end
    end

    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip

      if artist = Artist.find_by_name(input)
        artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
          puts "#{i}. #{s.name} - #{s.genre.name}"
        end
    end
end