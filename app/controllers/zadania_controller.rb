class ZadaniaController < ApplicationController
  before_filter :login_required, :except => :index
  before_filter :pobierz_liste, :except => :index

  helper_method :subskrybuje?
  tab :moje
  
  def index
    @lista = Lista.find_by_permalink(params[:lista_id])
    @zadania = @lista.zadania.find_ordered.group_by(&:zrobione)
    
    if own?(@lista)
      @current_tab = :moje
      render :action => 'index'
    else
      if @lista.udostepnienie == 1
        @current_tab = subskrybuje?(@lista) ? :obserwowane : :publiczne
        render :action => 'public'
      else
        redirect_to root_path
      end
    end
  end
  
  def order
    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.js do
          params[:do_zrobienia].each_with_index do |id, index|
            temp = @lista.zadania.find(id, :select => "id,lista_id, `order`")
            unless temp.order == index
              temp.not_cache_counter = true
              temp.update_attribute :order, index
            end
          end
          
        render :nothing => true
      end
    end
  end
  
  def toggle
    respond_to do |format|
      format.html { redirect_to lista_zadania_path( @lista ) }
      format.js do
        @zadanie = @lista.zadania.find(params[:id], :select => "id, zrobione, nazwa, lista_id, `order`")
        
        @zadanie.toggle(:zrobione)
        @zadanie.order!
        @zadanie.save
        
        msg = "'#{@zadanie.nazwa}' zostało "
        if @zadanie.zrobione
          msg += 'zrobione'
        else
          msg += 'anulowane'
        end
        
        aktualizuj_subskrypcje @lista, msg
      end
    end
  end

  def create
    @zadanie = @lista.zadania.new(params[:zadanie])
    @zadanie.order!
    respond_to do |format|
      if @zadanie.save
        flash[:notice] = 'Zadanie zostało stworzone!'
        
        aktualizuj_subskrypcje @lista, "nowe zadanie: ''#{@zadanie.nazwa}'"
        
        format.html { redirect_to lista_zadania_path(@lista) }
        format.js 
        format.xml  { render :xml => @zadanie, :status => :created, :location => @zadanie }
      else
        format.html { redirect_to lista_zadania_path(@lista) }
        format.js
        format.xml  { render :xml => @zadanie.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @zadanie = @lista.zadania.find(params[:id], :select => "id, lista_id, nazwa")
    msg = "zmiana zadania '#{@zadanie.nazwa}'"
    respond_to do |format|
      if @zadanie.update_attributes(params[:zadanie])
        
        aktualizuj_subskrypcje @lista, "#{msg} na: '#{@zadanie.nazwa}'"
        
        format.json { render :json => @zadanie }
        format.xml  { head :ok }
        format.js { render :nothing => true }
      else
        format.json do
          render :layout => false, :inline => "Błąd: #{@zadanie.errors.full_messages}", :status => 444
        end
      end
    end
  end

  def destroy
    @zadanie = @lista.zadania.find(params[:id], :select => "id, lista_id, nazwa")
    aktualizuj_subskrypcje @lista, "usunięto zadanie '#{@zadanie.nazwa}'"
    @zadanie.destroy

    respond_to do |format|
      format.html { redirect_to lista_zadania_path(@lista) }
      format.js { render :nothing => true }
      format.xml  { head :ok }
    end
  end
  
  def show  
    respond_to do |format|
      format.html { redirect_to @lista }
    end
  end
  
  protected
    def pobierz_liste
      begin
        @lista = self.current_uzytkownik.listy.find_by_permalink(params[:lista_id], :select => "id, udostepnienie, nazwa, permalink")
      rescue ActiveRecord::RecordNotFound 
        redirect_to listy_path
      end
    end
    
    def subskrybuje?(lista)
      lista.subskrypcje.find_by_uzytkownik_id(self.current_uzytkownik, :select => "id")
    end
end
