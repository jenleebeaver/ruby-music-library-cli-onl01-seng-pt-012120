
class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist #initializing one artist
    self.genre = genre if genre #initializing one genre
  end

  def artist=(artist) #here we are initializing an optional artist argument
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all #stores all instances of class Song to array @@all
    @@all
  end

  def save
    self.class.all << self #stores all saved instances of class using method .all and adds the instances to @@all
  end

  def self.destroy_all
    all.clear #allows us to empty our @@all array
  end

  def self.create(name) #implement custom constructor .create
    song = new(name) #instantiate instance using .new
    song.save #invokes save on new instance immediately
    song
  end

  def self.find_by_name(name)
    all.detect{ |s| s.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
  end

  def self.create_from_filename(filename) #here we are saving all songs from our new song object based on the filename
    new_from_filename(filename).tap{ |s| s.save }
  end

end
