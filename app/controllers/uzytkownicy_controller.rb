class UzytkownicyController < ApplicationController
  
  before_filter :login_required, :only => :ustawienia
  tab :rejestracja, :only => [:rejestracja, :nowy]
  tab :zaloguj, :only => :zaloguj
  tab :ustawienia, :only => :ustawienia
  
  def zaloguj
    return unless request.post?
    self.current_uzytkownik = Uzytkownik.authenticate(params[:login], params[:password])
    
    if logged_in?
      if params[:remember_me] == "1"
        current_uzytkownik.remember_me unless current_uzytkownik.remember_token?
        cookies[:auth_token] = { :value => self.current_uzytkownik.remember_token , :expires => self.current_uzytkownik.remember_token_expires_at }
      end
      
      redirect_back_or_default(listy_path)
      flash[:notice] = "Zostałeś zalogowany!"
    else
      flash[:error] = "Nieprawidłowe hasło lub login!"
    end
  end

  def wyloguj
    self.current_uzytkownik.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Zostałeś wylogowany!"
    redirect_back_or_default('/')
  end

  def ustawienia
    @uzytkownik = Uzytkownik.find(self.current_uzytkownik.id)  
    return unless request.put?
    stary = @uzytkownik.jid
    @uzytkownik.jid_required = ! params[:uzytkownik][:jid].blank?
    if @uzytkownik.update_attributes(params[:uzytkownik]) && !@uzytkownik.jid.blank?
      jabber_subskrybuj @uzytkownik, stary
    end
    
  end

  def nowy
    @uzytkownik = Uzytkownik.new(params[:uzytkownik])
    return unless request.post?
    cookies.delete :auth_token
    @uzytkownik.save
    if @uzytkownik.errors.empty?
      self.current_uzytkownik = @uzytkownik
      redirect_back_or_default(listy_path)
      flash[:notice] = "Zostałeś zarejestrowany!"
    end
  end

end
