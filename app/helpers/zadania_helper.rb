module ZadaniaHelper
  def zadanie_id(ob)
    "zadanie_#{ob.id}"
  end
  
  def zadanie_check(ob)
    "check_#{ob.id}"
  end
  
  def zadanie_spin(ob)
    "spinner_#{ob.id}"
  end
  
  def zadanie_edt(ob)
    "zadanie_#{ob.id}_nazwa"
  end
  
  def dzisiaj?(zadanie)
    data = zadanie.updated_at
    if data.strftime("%d-%m-%y") == Time.now.strftime("%d-%m-%y")
      "#{distance_of_time_in_words_pl(data)} temu"
    else
      data.strftime("%d/%m/%Y")
    end
  end
   
    def tekst(zad)
      h zad.nazwa
    end
end
