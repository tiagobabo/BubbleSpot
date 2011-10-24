class MudancasGeoLocalizacao < ActiveRecord::Migration
  def up
    add_column :shoppings, :latitude, :float
    add_column :shoppings, :longitude, :float
  end

  def down
    remove_column :shoppings, :coordenadas
  end
end
