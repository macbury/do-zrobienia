ActionController::Routing::Routes.draw do |map|
  
  map.publiczne_listy 'publiczne', :controller => "listy", :action => "publiczne"  
  map.publiczna_lista 'publiczne/:lista_id', :controller => "zadania", :action => "index"
  
  map.obserwowane_listy 'obserwowane', :controller => "listy", :action => "obserwowane"
  map.obserwuje_liste 'obserwowane/:lista_id', :controller => "zadania", :action => "index"
  
  map.resources :listy, :has_many => :zadania, :member => { :udostepnij => :get, :subskrybuj => :get }, :collection => { :tag => :get }
  
  map.with_options :controller => "uzytkownicy" do |uzytkownik|
    uzytkownik.wyloguj "wyloguj", :action => "wyloguj"
    uzytkownik.zaloguj "zaloguj", :action => "zaloguj"

    uzytkownik.ustawienia "ustawienia", :action => "ustawienia"
    uzytkownik.rejestruj "rejestracja", :action => "nowy"
  end
  
  map.glowna 'glowna', :controller => "strona", :action => "glowna"
  
  map.root :controller => "strona", :action => "index" 

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
