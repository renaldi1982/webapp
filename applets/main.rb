module WebApplication

  class WebApp < Sinatra::Base
    #register sinatra validation method so we can use our helpers function
    register Sinatra::SessionAuth
    register Sinatra::Query
    
    #enable sessions for login autentication
    enable :sessions
    
    #set path for layout and views
    set :haml, :layout => :'/layout'
    set :views, Proc.new { File.join(root, "../views") }
  end
    
end