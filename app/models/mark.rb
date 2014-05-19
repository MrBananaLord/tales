class Mark < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  mount_enumeration :value, Enumerations::Mark::Value,
                    default: "3", set_default_on_initialize: true
                    
  
end
