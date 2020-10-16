class MusicImporter
    attr_accessor :path

    def initialize(file_path)
        @path = file_path
    end
    
    def files
        files = Dir.entries(@path)
        files  = files[2..-1]    
    end

    def import
        self.files.each do |file|
            Song.create_from_filename(file)
        end
    end
end