class MudancaText2 < ActiveRecord::Migration
  def up
  	change_column :shoppings, :descricao, :text, :limit => nil
  end

  def down
  end
end
