class DodajListaZadaniaCountCache < ActiveRecord::Migration
  def self.up
    add_column :listy, :zadania_count, :integer, :default => 0
  end

  def self.down
  end
end
