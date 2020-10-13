class MusicImporter
  attr_accessor :path
  attr_reader :files
  
  def initialize(path)
    @path = path
    @files =[]
    @files << self
  end
  
  def files
    Dir.glob("#{path}/*.mp3").collect do |filepath|
      filepath.gsub("./spec/fixtures/mp3s/", "")
    end
  end
  
end