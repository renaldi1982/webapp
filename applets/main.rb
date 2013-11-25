module WebApplication

  class MainApp < Sinatra::Base
    #register sinatra validation method so we can use our helpers function
    register Sinatra::SessionAuth
    register Sinatra::Query
    register Sinatra::ParamHashiefier
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash    
    helpers Sinatra::JSON

    helpers Sinatra::RedirectWithFlash

    
    #enable sessions for login autentication
    enable :sessions
    
    #set path for layout and views
    set :haml, :layout => :'/layout'
    set :views, Proc.new { File.join(root, "../views") }
  end
    
end