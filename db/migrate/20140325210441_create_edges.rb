class CreateEdges < ActiveRecord::Migration
  def change
    create_table :edges do |t|
      t.text :content
      t.references :tail, index: true
      t.references :head, index: true

      t.timestamps
    end
  end
end
