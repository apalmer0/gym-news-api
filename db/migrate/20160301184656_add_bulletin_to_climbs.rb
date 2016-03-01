class AddBulletinToClimbs < ActiveRecord::Migration
  def change
    add_reference :climbs, :bulletin, index: true, foreign_key: true
  end
end
