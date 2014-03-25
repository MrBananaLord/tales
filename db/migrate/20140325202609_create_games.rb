class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.timestamp :published_at
      t.references :owner, index: true
      t.references :first_node, index: true

      t.timestamps
    end
  end
end
