module ListyHelper
  def pozostalo(lista, usun = true)
    ile = lista.zadania_count
    
    unless ile.nil? || ile == 0
      content_tag :span, " - pozostało #{ile}", :class => "zostalo"
    else
      ' - ' + link_to_remote("usuń", :url => lista, 
                                     :confirm => "Czy na pewno chcesz usunąć tą liste?", 
                                     :method => :delete,
                                     :complete => "Effect.Fade('lista_#{lista.id}')") if usun
    end
  end
  
  def lista_image(lista)
    ile = lista.zadania_count
    if ile == 0
      'lista'
    else
      'lista_zrobiona'
    end
  end
  
end