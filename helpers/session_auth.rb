module Sinatra
  module SessionAuth
    
    module Helpers
      def authorized?
        session[:authorized] && session[:user]
      end
          
      def current_user
        User.first(:username => session[:user])
      end
      
      def authorize!        
        redirect '/login' unless authorized? && current_user
      end
      
      def logout!        
        session.clear
      end 
    #end helpers  
    end  
    
    def self.registered(app)
      app.helpers SessionAuth::Helpers
      app.helpers Sinatra::RedirectWithFlash
      
      route = app.to_s[/WebApplication::([A-Za-z]+)App/,1]
      puts "printing route : #{route}"
      if route.downcase! == 'main'
          
        app.get '/login' do
          haml :login
        end
      
<<<<<<< HEAD
        app.post '/login' do          
=======
        app.post '/login' do
>>>>>>> 639cc153cc5157a8527b2f6e2934d32995abad57
          if user = User.first(:username => params.username, :password => Digest::MD5.hexdigest(params.password))
            session[:authorized] = true
            session[:user] = user.username            
            puts "#{user.username} is logged in!"
            redirect "/", :notice => "Welcome #{user.username.capitalize}"
          else          
            puts 'invalid login details!'
            redirect '/login', :error => "Invalid login details"
          end
        end        
        
        app.get '/logout' do
          logout!
          redirect '/index', :notice => "See you and have a nice day"          
        end
      else
        app.get '/login' do
          redirect '/login'
        end  
        
        app.get '/logout' do
          logout!
          redirect '/index', :notice => "See you and have a nice day"        
        end
      end      
    #end self.registered  
    end
                 
  #end module SessionAuth  
  end
#end module Sinatra  
end