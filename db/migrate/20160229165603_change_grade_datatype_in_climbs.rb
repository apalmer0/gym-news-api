class ChangeGradeDatatypeInClimbs < ActiveRecord::Migration
  def up
    change_table :climbs do |t|
      t.change :grade, :string
    end
  end

  def down
    change_table :climbs do |t|
      t.change :grade, :integer
    end
  end
end
