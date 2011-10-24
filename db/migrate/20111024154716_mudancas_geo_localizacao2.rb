class MudancasGeoLocalizacao2 < ActiveRecord::Migration
  def up
    remove_column :shoppings, :coordenadas
  end

  def down
  end
end
