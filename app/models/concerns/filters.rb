module Filters
  extend ActiveSupport::Concern
  
  included do
    def filters
      self.class.filters
    end
    
    def self.filters
      @filters
    end
    
    def filter(name)
      filters.select{ |filter| filter.value = name }
    end
    
    private
    
    def self.set_filters(*filters)
      @filters = filters.map{ |filter| Filter.new(self, filter) }
    end
  end
end
