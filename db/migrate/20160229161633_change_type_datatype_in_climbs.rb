class ChangeTypeDatatypeInClimbs < ActiveRecord::Migration
  def up
    change_table :climbs do |t|
      t.change :type, :string
    end
  end

  def down
    change_table :climbs do |t|
      t.change :type, :integer
    end
  end
end
