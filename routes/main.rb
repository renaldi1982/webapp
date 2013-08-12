module WebApplication
  
  class WebApp < Sinatra::Base
    
    get '/' do
           
      if authorize! 
        @message = "Welcome #{current_user.username.capitalize}!"
        haml :index
      else
        @message = "Welcome, please login or signup if you don't have an account yet"
        haml :index
      end
      
    end    
    
    get '/signup' do
      #authorize request
      authorize!
      
      haml :signup
      
    end
    
    post '/signup' do
            
      begin
        User.create(:username => params['username'], :password => params['password'], :email => params['email'], 
          :first_name => params['first_name'], :last_name => params['last_name'], :admin => false)
        #redirect to main page if the sign up is succesful
        puts "#{params['username']}, sign up sucessful"
        
        #authorize request
        if !authorize!
          @message = "Hi #{params['username'].capitalize}, you've been signed up. Please login"
        else
          @message = "#{params['username'].capitalize} has been added to the database"
        end
        haml :index
        
        rescue Sequel::UniqueConstraintViolation
        #stay in signup if there's exception
        @message = "unique constraint on user name error"
        puts 'unique constraint on user name error'
        #authorize request
        authorize!
        haml :signup
      
      end
      
    end
        
  #end of our module class WebApp
  end
end
