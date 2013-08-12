module Sinatra
  module Query
    
    module Helpers
      #get all the user in the database
      def get_users
        User.all
      end
      
      def delete_user(id)
        User.where(:id => params['id']).delete
      end
      
      def get_user_info(id)
        User.first(:id => params['id'])
      end
      
      def update(id, u_username, u_password, u_email, u_fName, u_lName, u_admin)
        
        params['u_admin'] = false unless params['u_admin'] == 'on'
        
        begin
            
          @mod_user = get_user_info(params['id'])  
          @mod_user.update(:username => params['u_username'], :password => params['u_password'], :email => params['u_email'], 
              :first_name => params['u_fName'], :last_name => params['u_lName'], :admin => params['u_admin'])
                    
        end
    
      end
        
    end
    
    def self.registered(app)
    #include helpers define above
    app.helpers Query::Helpers
    app.helpers SessionAuth::Helpers
    
    app.get '/dbview' do
      #check if user is authorized
      authorize!
      
      #get all users 
      @users = get_users
      haml :dbview
    end
    
    app.post '/dbview' do
             
      #get radOptions value from /dbview
      rad_val = params['radOptions']
      #get id from /dbview
      id = params['id'] 
          
      #get user information based on the id
      @mod_user = get_user_info(id)
    
      #check if user exist, or check if id is null and user that will be deleted is not admin
      if @mod_user == nil 
          
        @message = "User does not exist/id input is not right"
        
        #Check if authorized 
        authorize!
        haml :dbview
             
      else
        #radio button delete selected
        if rad_val == 'delete' 
          #call method delete form helpers
          if @mod_user.admin != true
            delete_user(id)
            @message = "#{@mod_user.username} has been deleted" 
            @users = get_users
            #Check if authorized 
            authorize!
            haml :dbview
          else
            @message = "There's error in deletion, make sure you insert the correct user ID(Note you can't delete admin)"
            @users = get_users
            #Check if authorized
            authorize!
            haml :dbview
          #end deletion 
          end
          
        else         
          
          @update_selected = true
          @users = get_users
          
          #check if id match user that we want to update and required fields are not empty
          if params['u_username'] == nil 
            
            @update_selected = true
            @users = get_users
            
            #Check if authorized
            authorize!
            haml :dbview
              
          else
            if params['id'] != id || params['u_username'] == nil || params['u_password'] == nil || 
              params['u_email'] == nil
              
              @message = "Please make sure that you want to update the right user, and all required fields are not empty"
              
              @update_selected = true
              @users = get_users
            
              #Check if authorized
              authorize!
              haml :dbview
              
            else
              #call update from helpers
              update(id, params['u_username'], params['u_password'], params['u_email'], params['u_fName'], params['u_lName'],
              params['u_admin'])
            
              @update_selected = false
              @users = get_users
              @message = "Record ID: #{params['id']} has been updated"
            
              #Check if authorized
              authorize!
              haml :dbview
               
            end
            
          #end update   
          end               
              
        #end delete/update  
        end
          
      #end check mod_user is nil      
      end        
     
    #end of app.post '/dbview'  
    end
    
    #end self.registered(app)  
    end
    
  #end module Deletion  
  end
#end module Sinatra  
end