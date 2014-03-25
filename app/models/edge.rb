class Edge < ActiveRecord::Base
  belongs_to :tail, class_name: "Node"
  belongs_to :head, class_name: "Node"
end
