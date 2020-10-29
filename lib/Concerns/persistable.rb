module Persistable

    module InstanceMethods

        def save         # instance method
            self.all << self
        end
    end


    module ClassMethods
        def reset_all      # class method
            self.all.clear
        end

        def count         # class method
            self.all.size 
        end

        def destroy_all
            self.all.clear
        end

        def self.create(name)
            new(name).tap{|a| a.save}
        end
    end

end