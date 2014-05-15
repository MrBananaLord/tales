class RenameColumnFirstNodeIdToFirstParagraphIdInGames < ActiveRecord::Migration
  def change
    rename_column :games, :first_node_id, :first_paragraph_id
  end
end
