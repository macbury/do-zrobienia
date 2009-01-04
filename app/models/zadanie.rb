class Zadanie < ActiveRecord::Base
  
  xss_terminate
  
  belongs_to :lista
  validates_presence_of :nazwa
  validates_length_of :nazwa, :within => 3..255
  
  after_save :update_cache_counter
  after_destroy :update_cache_counter
  
  attr_accessor :not_cache_counter
  
  attr_accessible :nazwa, :zrobione
  
  def order!
    t = Zadanie.find(:first, :select => "MAX(`order`) AS `MAX`", :conditions => "zrobione = #{self.zrobione} AND lista_id = #{self.lista_id}")
    self.order = t.MAX.to_i + 1
  end
  
  def self.find_ordered
    find(:all, :order => "`order`")
  end
  
  def update_cache_counter
    unless not_cache_counter
      zadanie_count = Zadanie.count :conditions => ["zrobione = 0 AND lista_id = ? ", self.lista_id]
      lista = Lista.find(self.lista_id, :select => "id, zadania_count")
      lista.update_attribute :zadania_count, zadanie_count
    end
  end
end
