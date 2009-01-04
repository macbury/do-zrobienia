class Lista < ActiveRecord::Base
  belongs_to :uzytkownik
  
  acts_as_taggable
  xss_terminate
  
  has_many :zadania, :dependent => :destroy
  has_many :subskrypcje, :dependent => :destroy
  has_many :obserwoja, :source => :uzytkownik, :through => :subskrypcje
  
  validates_length_of :nazwa, :within => 3..64
  validates_length_of :opis, :maximum => 500
  
  attr_accessible :nazwa, :opis, :pokaz_autora, :udostepnienie, :pokaz_czas_ukonczenia, :pokaz_w_publicznych, :tag_list
  before_create :generuj_permalink
  
  def to_param
    permalink
  end
  
  def after_destroy
    zadania = self.zadania.find(:all, :select => "id")
    zadania.each do |zad|
      zad.not_cache_counter = true
      zad.destroy
    end
  end
  
  def self.find_for_index
    find(:all, 
         :order => "created_at AND zadania_count DESC")
  end
  
  def generuj_permalink
    while true
      per = rand(9_999_999_999)
      break if Lista.find_by_permalink(per, :select => 'id').blank?
    end
    
    self.permalink = per.to_s(32)
  end
end