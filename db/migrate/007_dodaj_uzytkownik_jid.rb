class DodajUzytkownikJid < ActiveRecord::Migration
  def self.up
    add_column :uzytkownicy, :jid, :string, :size => 255
  end

  def self.down
  end
end
