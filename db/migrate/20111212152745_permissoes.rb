class Permissoes < ActiveRecord::Migration
  def up
  	add_column :admins, :idref, :integer
  end

  def down
  end
end
