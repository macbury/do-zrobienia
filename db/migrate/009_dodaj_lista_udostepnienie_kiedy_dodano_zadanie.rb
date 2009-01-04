class DodajListaUdostepnienieKiedyDodanoZadanie < ActiveRecord::Migration
  def self.up
    add_column :listy, :pokaz_czas_ukonczenia, :boolean, :default => false
  end

  def self.down
  end
end
