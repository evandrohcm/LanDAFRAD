# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150118005223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acessos", force: true do |t|
    t.float    "valor"
    t.integer  "duracao"
    t.integer  "cliente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acessos", ["cliente_id"], name: "index_acessos_on_cliente_id", using: :btree

  create_table "clientes", force: true do |t|
    t.string   "nome"
    t.string   "cpf"
    t.date     "data_nasc"
    t.integer  "qtd_acesso"
    t.float    "bonus_acumulado"
    t.integer  "horas_gratis"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
