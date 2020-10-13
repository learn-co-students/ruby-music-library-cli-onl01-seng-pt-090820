require 'pry'
require 'bundler'
Bundler.require

module Concerns
  module Findable
    
    def find_by_name(name)
      all.find{|a| a.name == name}
    end
    
    def find_or_create_by_name(name)
      find_by_name(name) || create(name)
    end
    
  end
end

require_all 'lib'
