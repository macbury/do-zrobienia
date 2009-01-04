module JabberBot
  def jabber_message(odbiorca, tresc)
    return if odbiorca.nil? || tresc.nil?
    JABBER_CLIENT.deliver odbiorca, tresc
  end
  
  def jabber_message_for uzytkownik, tresc
    return if uzytkownik.jid.blank?
    jabber_message uzytkownik.jid, tresc
  end
  
  
  def jabber_subskrybuj(user, stary_jid)
    unless stary_jid == user.jid
      JABBER_CLIENT.remove stary_jid
    end
    JABBER_CLIENT.add user.jid
    jabber_message_for user, "Aktywacja bota w serwisie dozrobienia.pl przebiegła prawidłowo. Teraz dodaj ten kontakt do swojego rostera."
  end
  
  def aktualizuj_subskrypcje( lista , msg)
    if lista.udostepnienie == 1
      sub = lista.subskrypcje.find(:all, 
              :select => "uzytkownicy.jid",
              :joins => "LEFT OUTER JOIN uzytkownicy ON uzytkownicy.id = subskrypcje. uzytkownik_id",
              :conditions => "uzytkownicy.jid IS NOT NULL" )
      sub.each do |s|
        jabber_message s.jid, "Użytkownik #{self.current_uzytkownik.login} w liście #{@lista.nazwa}: \n#{msg} \nLista url: #{lista_url(@lista)}"
      end
    end
  end
end