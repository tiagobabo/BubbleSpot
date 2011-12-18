class MudancaText3 < ActiveRecord::Migration
  def up
  	change_column :promos, :imagem, :text, :limit => nil
  	change_column :lojas, :detalhes, :text, :limit => nil
  	change_column :lojas, :imagem, :text, :limit => nil
  	change_column :filmes, :detalhes, :text, :limit => nil
  	change_column :filmes, :horarios, :text, :limit => nil
  	change_column :filmes, :imagem, :text, :limit => nil
  	change_column :eventos, :detalhes, :text, :limit => nil
  	change_column :eventos, :imagem, :text, :limit => nil
  	change_column :shoppings, :imagem, :text, :limit => nil
  	change_column :shoppings, :link_mapa, :text, :limit => nil
  	change_column :shoppings, :localizacao, :text, :limit => nil
  end

  def down
  end
end
