class RenameColumnsInChoices < ActiveRecord::Migration
  def change
    rename_column :choices, :tail_id, :parent_paragraph_id
    rename_column :choices, :head_id, :child_paragraph_id
  end
end
