class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome
      t.references :shopping
      t.datetime :data
      t.string :detalhes
      t.string :imagem

      t.timestamps
    end
    add_index :eventos, :shopping_id
  end
end
