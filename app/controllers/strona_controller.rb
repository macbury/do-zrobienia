class StronaController < ApplicationController
  tab :glowna
  
  def index
    redirect_to glowna_path
  end
  
  def stats
    
  end
end
