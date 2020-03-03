
class MusicImporter #this works with song, genre, and artist objects to import a directory of MP3 files
  attr_reader :path

  def initialize(path) #accepts a file path to a directory of MP3 files
    @path = path
  end

  def files #returns all of the imported file names
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
    #Dir = directory in the underlying file system/ lists directories and their contents
    #glob = allows you to select the files you want
    #gsub = used to return a copy of the string ??
  end

  def import #imports all of the files from the library
    files.each{ |f| Song.create_from_filename(f) } #instantaites a new Song object for each file
  end
end
