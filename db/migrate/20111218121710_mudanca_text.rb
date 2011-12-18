class MudancaText < ActiveRecord::Migration
  def up
  	change_column :shoppings, :descricao, :text
  end

  def down
  end
end
