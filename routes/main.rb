class WebApp < Sinatra::Application
  
  #redirect to the main page
  get '/' do
    @greetings = "Hi all!"
    haml :index
  end
  
  #redirect to signup page
  get '/signup' do
    haml :signup
  end
  
  #save the input data to the database 
  post '/signup' do
    
    begin
      User.create(:username => params['username'], :password => params['password'], :email => params['email'], 
        :first_name => params['first_name'], :last_name => params['last_name'])
      #redirect to main page if the sign up is succesful
        puts 'sign up sucessful'
        redirect '/'
    rescue Sequel::UniqueConstraintViolation
    #stay in signup if there's exception
    puts 'unique constraint on user name error'
    redirect '/signup'
      
    end
    
  end   
  
  #redirect to login page
  get '/login' do
    
    haml :login
    
  end
  
  #process login 
  post '/login' do
    if(validate(params["username"], params["password"]))
      #puts "login successed"
      session["logged_in"] = true
     
      # NOTE the right way to do messages like this is to use Rack::Flash
      # https://github.com/nakajima/rack-flash
      #@message = "You've been logged in."
      haml :index
    else
      #puts "error"
      # See note above
      @error_message = "Sorry, those credentials aren't valid."
      haml :login
    end
  end
    
  get '/dbview' do
    @er_message = nil
    @users = User.all
    
    haml :dbview
  end
  
  #take care of delete/update record from database
  post '/dbview' do
    
    begin
      
      #pass value of radio buttons and id to ruby code
      value = params['radOptions']
      id = params['id']
      
      #find if user id exist
      valid_id = User.first(:id => id)
            
      if(id == '')
        puts 'no id input'
        @er_message = "Please type id that you want to delete / update"
        @users = User.all
        haml :dbview

      else 
        if(value == 'delete')
          #call method delete from helpers
          delete(id)
          @users = User.all
          haml :dbview
        
        else if(value == 'update' and params['u_username'] == nil)
          @id = id
          @update_selected = true
          #get the user info and pass it back to the page to be displayed in the input box
          get_user_info(id)
          
          
                    
          @users = User.all
          haml :dbview
          
        else 
          
          @update_selected == false          
          
          update(params['u_username'], params['u_password'], 
          params['u_email'], params['u_fName'], params['u_lName'])
          
          @users = User.all
          haml :dbview
        end        
        
      end
      
    end
    end
  end
  
  #process logout
  get '/logout' do
  
  @message = "You've been logged out."  
  clear_session
  haml :index
  
  end
end
