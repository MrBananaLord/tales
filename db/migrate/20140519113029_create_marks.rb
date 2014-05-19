class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.references :game, index: true
      t.references :user, index: true
      t.integer :value

      t.timestamps
    end
  end
end
