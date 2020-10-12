module Memorable
    module ClassMethods
        
        def destroy_all
            self.all.clear
        end

        def create(name)
            new_instance = self.new(name)
            new_instance.save
            new_instance
        end
    end

    module InstanceMethods
        
        def initialize(name)
            self.name = name
            @songs = []
        end

        def save
            self.class.all << self
        end

        def songs
            @songs
        end
    end
end