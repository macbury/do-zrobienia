class CreateZadania < ActiveRecord::Migration
  def self.up
    create_table :zadania do |t|
      t.string :nazwa
      t.boolean :zrobione, :default => false
      t.integer :lista_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :zadania
  end
end
