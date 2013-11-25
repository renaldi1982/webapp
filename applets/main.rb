module WebApplication

  class MainApp < Sinatra::Base
    #register sinatra validation method so we can use our helpers function
    register Sinatra::SessionAuth
    register Sinatra::Query
    register Sinatra::ParamHashiefier
    register Sinatra::Flash
<<<<<<< HEAD
    helpers Sinatra::RedirectWithFlash    
    helpers Sinatra::JSON
=======
    helpers Sinatra::RedirectWithFlash
>>>>>>> 639cc153cc5157a8527b2f6e2934d32995abad57
    
    #enable sessions for login autentication
    enable :sessions
    
    #set path for layout and views
    set :haml, :layout => :'/layout'
    set :views, Proc.new { File.join(root, "../views") }
  end
    
end