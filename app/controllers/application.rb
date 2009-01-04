# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  include AuthenticatedSystem
  
  include JabberBot
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8fc8f3553ba8882af335675ef70def7e'
  
  protected
  
  def self.tab(name, options = {})
    before_filter(options) do |controller|
      controller.instance_variable_set('@current_tab', name)
    end
  end
  
  def own?(obj)
    (self.current_uzytkownik && self.current_uzytkownik.id == obj.uzytkownik_id)
  end
end
