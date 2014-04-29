class RenameTablesNodesAndEdges < ActiveRecord::Migration
  def change
    rename_table :nodes, :paragraphs
    rename_table :edges, :choices
  end
end
