class CreateSubskrypcje < ActiveRecord::Migration
  def self.up
    create_table :subskrypcje do |t|
      t.integer :lista_id
      t.integer :uzytkownik_id
    end
  end

  def self.down
    drop_table :subskrypcje
  end
end
