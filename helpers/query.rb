module Sinatra
  module Query
    
    module Helpers
      #get all the user in the database
      def get_users
        User.all
      end
      
      def delete_user(id)
        puts "deleting user id = #{id}"
        User.where(:id => params.id).delete
      end
      
      def get_user_info(id)
        User.first(:id => params.id)
      end
      
      def update(mod_user)               
        begin                     
          mod_user.update(:username => params.username, :password => Digest::MD5.hexdigest(params.password), :email => params.email, 
              :first_name => params.first_name, :last_name => params.last_name, :admin => params.admin)                   
        end    
      end       
       
    end
    
    def self.registered(app)
      #include helpers define above
      app.helpers Query::Helpers
      app.helpers SessionAuth::Helpers
      
      route = app.to_s[/WebApplication::([A-Za-z]+)App/,1]
      puts "printing route : #{route}"
      
      if route.downcase! == 'main'
        app.get '/user' do
          #check if user is authorized
          authorize!
          if current_user.admin
            #get all users 
            @users = get_users
            haml :user
          else
            redirect '/', :error => "#{current_user.username.capitalize}, you are not an admin"
          end
        end            
        
        #TODO fill this out
        app.post '/user' do
          #do deletion
          if authorized? 
            user = get_user_info(params.id)
            if !user.admin 
              delete_user(params.id) 
              redirect '/user', :notice => "Account has been deleted"
            else
              redirect '/user', :notice => "Can't delete an admin, update the admin status first"
            end    
          else          
            redirect '/', :error => "#{current_user.username.capitalize}, you are not an admin"
          end                                        
        #end of app.post '/dbview'  
        end
      
        app.get '/update_user_:id' do
          puts "called"
          #authorize
          puts params.id
          authorize!
          if current_user.admin            
            #get user info
            @user = User[params.id]
            haml :update_user
          else
            redirect '/', :error => "#{current_user.username.capitalize}, you are not an admin"  
          end       
        end
        
        #TODO fill this out
        app.post '/update_user_:id' do
          if current_user.admin
            #get user to modified
            mod_user = get_user_info(params.id)
            if params.chk_pass
              begin                     
                mod_user.update(:username => params.username, :password => Digest::MD5.hexdigest(params.password), :email => params.email, 
                  :first_name => params.first_name, :last_name => params.last_name, :admin => params.admin)                   
              rescue Sequel::UniqueConstraintViolation
                puts "Unique constrain violation"
                redirect '/update_user_:id', :error => "Unique constraint violation"
              end 
            else
              begin                     
                mod_user.update(:username => params.username, :email => params.email, 
                  :first_name => params.first_name, :last_name => params.last_name, :admin => params.admin)                   
              rescue Sequel::UniqueConstraintViolation
                puts "Unique constrain violation"
                redirect '/update_user_:id', :error => "Unique constraint violation"
              end    
            end
          else
            redirect '/', :error => "{current_user.username.capitalize}, you are not an admin"  
          end
        end
      
      #end if route == main
      end          
    #end self.registered(app)  
    end
    
  #end module Deletion  
  end
#end module Sinatra  
end