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
        return false unless authorized? && current_user
        @authorized = authorized?
        @user = current_user
      end
      
      def logout!
        #session[:authorized] = false
        #session[:user] = nil
        session.clear
      end 
    #end helpers  
    end  
    
    def self.registered(app)
      app.helpers SessionAuth::Helpers
     
      app.get '/login' do
        haml :login
      end
      
      app.post '/login' do
        if user = User.first(:username => params['username'], :password => params['password'])
          session[:authorized] = true
          session[:user] = user.username
          
          puts "#{user.username} is logged in!"
          redirect "/"
        else
          @message = "Invalid login details"
          puts 'invalid login details!'
          haml :login
        end
      end
      
      app.get '/logout' do
        logout!
        @message = "See you soon!!"
        haml :index
      end
      
    end
                 
  #end module SessionAuth  
  end
  register SessionAuth
#end module Sinatra  
end