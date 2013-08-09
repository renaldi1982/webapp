 
  def get_user_info(id)
    #get user id, username, email, first and last name
    @update_user = User.first(:id=> params['id'])
  end
  
  def update(u_username, u_password, u_email, u_fName, u_lName)
    
    begin
      if(params['u_username'] != nil)
        @update_user = User.first(:id=> params['id'])
        @update_user.update(:username => params['u_username'], :password => params['u_password'], :email => params['u_email'], 
          :first_name => params['u_fName'], :last_name => params['u_lName'])
        
        @er_message = "Record updated"    
        #print message in server if the update is successful
        puts 'update up sucessful'
      end      
    end
    
  end
  
