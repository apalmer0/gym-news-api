class ChangeTypeNameInClimbs < ActiveRecord::Migration
  def change
    rename_column :climbs, :type, :climb_type
  end
end
