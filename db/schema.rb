# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 13) do

  create_table "listy", :force => true do |t|
    t.string   "nazwa"
    t.text     "opis"
    t.integer  "uzytkownik_id",         :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zadania_count",         :limit => 11, :default => 0
    t.integer  "udostepnienie",         :limit => 2,  :default => 0
    t.boolean  "pokaz_czas_ukonczenia",               :default => false
    t.string   "permalink"
    t.boolean  "pokaz_w_publicznych",                 :default => true
  end

  create_table "subskrypcje", :force => true do |t|
    t.integer "lista_id",      :limit => 11
    t.integer "uzytkownik_id", :limit => 11
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :limit => 11
    t.integer  "taggable_id",   :limit => 11
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "uzytkownicy", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "jid"
  end

  create_table "zadania", :force => true do |t|
    t.string   "nazwa"
    t.boolean  "zrobione",                 :default => false
    t.integer  "lista_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order",      :limit => 11, :default => 0
  end

end
