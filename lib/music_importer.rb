require 'pry'

class MusicImporter
    attr_reader :path
    def initialize(path)
        # binding.pry
        @path = path
    end

    def files
        # binding.pry
        Dir.entries(@path).select {|p| p.include?(".mp3")}
        # Dir.glob("#{path}/*mp3").map {|filepath| filepath.gsub("./spec/fixtures/mp3s/", "")}  # hardcoded and fails print_songs in spec 011?
    end

    def import
        files.each {|filename| Song.create_from_filename(filename)}
    end
end