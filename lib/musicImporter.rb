class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path 
  end
  
  def files
    filenames = Dir.chdir(@path){|path| Dir.glob("*.mp3")}
    filenames
  end
  
  def import 
    filenames = self.files
    filenames.each{|filename| Song.create_from_filename(filename)}
  end
  
end