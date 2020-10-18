module Concerns::Findable
    
    def find_by_name(song)
        all.detect{|song_name| song_name.name == song}
    end

    def find_or_create_by_name(song)
        find_by_name(song) || self.create(song)
    end

end