class CreateClimbs < ActiveRecord::Migration
  def change
    create_table :climbs do |t|
      t.string :color
      t.integer :grade
      t.string :modifier

      t.timestamps null: false
    end
  end
end
