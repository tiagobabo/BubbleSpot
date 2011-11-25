class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.text :detalhes
      t.decimal :precoi
      t.decimal :precof
      t.decimal :desconto
      t.string :imagem
      t.references :loja
      t.datetime :dataf
      t.string :produto

      t.timestamps
    end
    add_index :promos, :loja_id
  end
end
