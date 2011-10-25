class CreateLojas < ActiveRecord::Migration
  def change
    create_table :lojas do |t|
      t.string :nome
      t.integer :piso
      t.integer :numero
      t.string :telefone
      t.string :detalhes
      t.string :imagem
      t.references :shopping

      t.timestamps
    end
    add_index :lojas, :shopping_id
  end
end
