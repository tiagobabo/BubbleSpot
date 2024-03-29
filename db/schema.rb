# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111218123635) do

  create_table "admins", :force => true do |t|
    t.string    "email"
    t.string    "password_hash"
    t.string    "password_salt"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "tipo"
    t.integer   "idref"
  end

  create_table "eventos", :force => true do |t|
    t.string   "nome"
    t.integer  "shopping_id"
    t.datetime "data"
    t.text     "detalhes"
    t.text     "imagem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "local"
  end

  add_index "eventos", ["shopping_id"], :name => "index_eventos_on_shopping_id"

  create_table "filmes", :force => true do |t|
    t.string   "nome"
    t.integer  "shopping_id"
    t.text     "detalhes"
    t.text     "horarios"
    t.text     "imagem"
    t.string   "trailer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sala"
  end

  add_index "filmes", ["shopping_id"], :name => "index_filmes_on_shopping_id"

  create_table "lojas", :force => true do |t|
    t.string   "nome"
    t.integer  "piso"
    t.integer  "numero"
    t.string   "telefone"
    t.text     "detalhes"
    t.text     "imagem"
    t.integer  "shopping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags"
  end

  add_index "lojas", ["shopping_id"], :name => "index_lojas_on_shopping_id"

  create_table "promos", :force => true do |t|
    t.text     "detalhes"
    t.decimal  "precoi"
    t.decimal  "precof"
    t.decimal  "desconto"
    t.text     "imagem"
    t.integer  "loja_id"
    t.datetime "dataf"
    t.string   "produto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags"
  end

  add_index "promos", ["loja_id"], :name => "index_promos_on_loja_id"

  create_table "shoppings", :force => true do |t|
    t.string   "nome"
    t.string   "telefone"
    t.text     "localizacao"
    t.string   "email"
    t.text     "descricao"
    t.text     "imagem"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "link_mapa"
  end

end
