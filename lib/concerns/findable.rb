module Concerns::Findable
    def find_by_name(item_name)
        all.each do |item|
            if item.name == item_name
                return item
            end
        end
        return
    end

    def find_or_create_by_name(item_name)
        if find_by_name(item_name).class == self
            return find_by_name(item_name)
        else
            return self.create(item_name)
        end
    end
end