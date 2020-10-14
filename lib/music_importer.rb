require 'pry'

class MusicImporter
  attr_accessor :path
  attr_reader :files
  
  def initialize(path)
    @path = path
    @files = []
    @files << self
  end
  
 def files
    Dir.glob("#{path}/*.mp3").collect do |filepath|
      filepath.split("/").last
    end
  end
  
  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end

end