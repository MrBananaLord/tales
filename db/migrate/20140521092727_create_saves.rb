class CreateSaves < ActiveRecord::Migration
  def change
    create_table :saves do |t|
      t.references :user, index: true
      t.references :paragraph, index: true
      t.references :game, index: true

      t.timestamps
    end
  end
end
