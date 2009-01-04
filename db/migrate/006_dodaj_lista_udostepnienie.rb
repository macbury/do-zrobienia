class DodajListaUdostepnienie < ActiveRecord::Migration
  def self.up
    add_column :listy, :udostepnienie, :integer, :limit => 2 ,:default => 0 
  end

  def self.down
  end
end
