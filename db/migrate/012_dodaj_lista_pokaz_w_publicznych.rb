class DodajListaPokazWPublicznych < ActiveRecord::Migration
  def self.up
    add_column :listy, :pokaz_w_publicznych, :boolean, :default => true
  end

  def self.down
  end
end
