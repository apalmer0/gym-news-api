class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.string :content
      t.references :gym, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
