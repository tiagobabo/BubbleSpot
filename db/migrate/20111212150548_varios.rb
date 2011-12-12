class Varios < ActiveRecord::Migration
  def up
  	add_column :promos, :tags, :string
  end

  def down
  end
end
