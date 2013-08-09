enable :sessions
  
  #define helpers
  helpers do
    
    def validate(username, password)
      #Validation logic here
      valid_user = User.first(:username => params['username'], :password => params['password'])
      #get user id, name and email address
      if (valid_user != nil)
        #get user id, name and email address
        session["id"] = valid_user.id
        session["username"] = valid_user.username
        session["email"] = valid_user.email
        session["first_name"] = valid_user.first_name
        session["last_name"] = valid_user.last_name
        
        return true
      else
        return false
        end  
    end
    
    def is_admin?
    
      if is_logged_in? 
        if session["id"] == 1
          return true
        end
      else
        return false
        
      end
    end
    
    #Validate if the user is logged in
    def is_logged_in?
      session["logged_in"] == true
    end
  
    #Clear session
    def clear_session
      @greetings = "See you around!"
      session.clear
    end
  
    #Get user name of the logged in user
    def the_user_name
      if is_logged_in? 
        session["username"]
      else
        "not logged in"
      end
    end
  end