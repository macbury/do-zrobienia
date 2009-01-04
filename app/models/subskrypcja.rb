class Subskrypcja < ActiveRecord::Base
  belongs_to :lista
  belongs_to :uzytkownik
end