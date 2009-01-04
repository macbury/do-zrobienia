class CreateListy < ActiveRecord::Migration
  def self.up
    create_table :listy do |t|
      t.string :nazwa, :size => 64
      t.text :opis
      t.integer :uzytkownik_id

      t.timestamps
    end
  end

  def self.down
    drop_table :listy
  end
end
