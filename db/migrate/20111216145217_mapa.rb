class Mapa < ActiveRecord::Migration
  def up
  	add_column :shoppings, :link_mapa, :string
  end

  def down
  end
end
