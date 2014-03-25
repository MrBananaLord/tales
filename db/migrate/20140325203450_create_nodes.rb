class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.text :content
      t.references :game, index: true

      t.timestamps
    end
  end
end
