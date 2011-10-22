class CreateShoppings < ActiveRecord::Migration
  def change
    create_table :shoppings do |t|
      t.string :nome
      t.string :telefone
      t.string :localizacao
      t.string :email
      t.string :descricao
      t.string :coordenadas
      t.string :imagem

      t.timestamps
    end
  end
end
