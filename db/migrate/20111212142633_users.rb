class Users < ActiveRecord::Migration
  def up
  	add_column :admins, :tipo, :integer
  end

  def down
  end
end
