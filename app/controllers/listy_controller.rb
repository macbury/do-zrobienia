class ListyController < ApplicationController
  before_filter :login_required, :except => [:show, :publiczne, :auto_complete_for_lista_tag_list]
  tab :moje, :except => [:publiczne, :obserwowane]
  tab :publiczne, :only => :publiczne
  tab :obserwowane, :only => :obserwowane
  
  def index
    @listy = self.current_uzytkownik.listy.find_for_index
    @tagi = self.current_uzytkownik.listy.tag_counts
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listy }
    end
  end

  def new
    @lista = self.current_uzytkownik.listy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lista }
    end
  end

  def tag
    if params[:tag_id] == 'all'
      @listy = self.current_uzytkownik.listy.find_for_index
    else
      @listy = self.current_uzytkownik.listy.find_tagged_with(params[:tag_id], :select => "listy.id, listy.zadania_count, listy.nazwa, listy.permalink" )
    end
    
    render :partial => @listy
  end

  def show
    respond_to do |format|
      format.html { redirect_to lista_zadania_path(params[:id]) }
    end
  end

  def edit
    begin
      @lista = self.current_uzytkownik.listy.find_by_permalink(params[:id])
      render :action => "new"
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nie znaleziono listy o podanym ID!"
      redirect_to listy_path
    end   
  end

  def create
    @lista = self.current_uzytkownik.listy.create(params[:lista])

    respond_to do |format|
      if @lista.save
        flash[:notice] = 'Lista zadań została stworzona'
        format.html { redirect_to lista_zadania_path(@lista) }
        format.xml  { render :xml => @lista, :status => :created, :location => @lista }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lista.errors, :status => :unprocessable_entity }
      end
    end

  end

  def update
    @lista = self.current_uzytkownik.listy.find_by_permalink(params[:id])
    respond_to do |format|
      if @lista.update_attributes(params[:lista])
        @lista.subskrypcje.destroy_all if @lista.udostepnienie == 0
        flash[:notice] = 'Lista została zapisana!'
        format.html { redirect_to lista_zadania_path(@lista) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lista.errors, :status => :unprocessable_entity }
      end
    end
  end

  def subskrybuj
    begin
      lista = Lista.find_by_permalink(params[:id], :select => "id, udostepnienie, permalink")
      if lista.udostepnienie == 1
        unless s = subskrybuje?(lista)
          sub = lista.subskrypcje.new
          sub.uzytkownik_id = self.current_uzytkownik.id
          sub.save
          flash[:notice] = "Ta lista jest teraz obserwowana!"
        else
          s.destroy
          flash[:notice] = "Przestano obserwować liste!"
        end
      else
        flash[:error] = "Nie można obserwować tej listy!"
      end
      
      redirect_to obserwuje_liste_path(lista)
      
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nie znaleziono listy o podanym ID!"
      redirect_to listy_path
    end
    
  end

  def obserwowane
    @sub = self.current_uzytkownik.obserwowane.all(:include => :uzytkownik).group_by(&:uzytkownik)
  end

  def udostepnij
    begin
      @lista = self.current_uzytkownik.listy.find_by_permalink(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Nie znaleziono listy o podanym ID!"
      redirect_to listy_path
    end
  end
  
  def destroy
    @lista = self.current_uzytkownik.listy.find_by_permalink(params[:id])
    @lista.destroy
    
    flash[:error] = "Lista została usunięta!"
    
    respond_to do |format|
      format.html { redirect_to(listy_url) }
      format.js do
        render :nothing => true 
        flash.discard 
      end
      format.xml  { head :ok }
    end
  end
  
  def publiczne
    @listy = Lista.paginate_all_by_udostepnienie_and_pokaz_w_publicznych( 1,true,
                                                 :order => "created_at DESC",
                                                 :per_page => 20,
                                                 :page => params[:page])
  end
  
  def auto_complete_for_lista_tag_list
    tag = params[:lista][:tag_list]
    unless tag.blank?
      @tagi = Tag.find(:all, 
                      :conditions => ['name LIKE ?', "#{tag}%"],
                      :limit => 10,
                      :order => "name")
      render :inline => "<%= auto_complete_result(@tagi, :name) %>", :layout => false
    else
      render :nothing => true
    end
  end
  
  protected
    def subskrybuje?(lista)
      lista.subskrypcje.find_by_uzytkownik_id(self.current_uzytkownik)
    end
end
