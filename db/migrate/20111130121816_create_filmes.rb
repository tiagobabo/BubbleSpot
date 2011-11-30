class CreateFilmes < ActiveRecord::Migration
  def change
    create_table :filmes do |t|
      t.string :nome
      t.references :shopping
      t.string :detalhes
      t.string :horarios
      t.string :imagem
      t.string :trailer

      t.timestamps
    end
    add_index :filmes, :shopping_id
  end
end
