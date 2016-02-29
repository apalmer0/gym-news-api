class AddTypeToClimbs < ActiveRecord::Migration
  def change
    add_column :climbs, :type, :string
  end
end
