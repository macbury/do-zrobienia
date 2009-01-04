class DodajListaPermalink < ActiveRecord::Migration
  def self.up
    add_column :listy, :permalink, :string
    listy = Lista.find(:all)
    listy.each do | l |
      l.permalink = l.id.to_s(16)
      l.save
    end
  end

  def self.down
  end
end
