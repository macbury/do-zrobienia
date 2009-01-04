class DodajZadaniaOrder < ActiveRecord::Migration
  def self.up
    add_column :zadania, :order, :integer, :default => 0
  end

  def self.down
  end
end
