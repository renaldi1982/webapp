module WebApplication  
  class MainApp < Sinatra::Base
    
    get '/' do
      if !authorized?      
        haml :index
      else
        redirect '/index', :notice => "Welcome #{current_user.username.capitalize}"
      end
    end    
    
    get '/index' do
      authorize!
      haml :index
    end
    
    get '/signup' do
      if !authorized?
        haml :signup
      elsif authorized? && !current_user.admin 
        redirect '/', :error => "#{current_user.username}, you are not an admin"
      elsif authorized? && current_user.admin
        haml :signup, :notice => "Admin : #{current_user.username.capitalize}"
      end              
    end
    
    post '/signup' do
      #check if the user is admin
      if !authorized?
        begin
          User.create(:username => params.username, :password => Digest::MD5.hexdigest(params.password), :email => params.email, 
            :first_name => params.first_name, :last_name => params.last_name, :admin => false)
          #redirect to main page if the sign up is succesful
          puts "#{params['username']}, sign up sucessful"        
          redirect '/', :notice => "You've been signed up, please login"
          
        rescue Sequel::UniqueConstraintViolation
          #stay in signup if there's exception          
          puts 'unique constraint on user name error'
          redirect '/signup', :error => "Please insert another username"
        end      
      else
        begin
          if params.admin
            admin = true
          else
            admin = false
          end
          User.create(:username => params.username, :password => Digest::MD5.hexdigest(params.password), :email => params.email, 
            :first_name => params.first_name, :last_name => params.last_name, :admin => admin)
          #redirect to main page if the sign up is succesful
          puts "#{params['username']}, sign up sucessful"        
          redirect '/dbview', :notice => "#{params.username.capitalize}, has been added"
          
        rescue Sequel::UniqueConstraintViolation
          #stay in signup if there's exception          
          puts 'unique constraint on user name error'
          redirect '/signup', :error => "Please insert another username"
        end      
      end  
    end                
    
    get '/about' do 
      haml :about
    end
    
    post '/about' do
      #puts params.input1
      #puts params.input2
      @result = params.input1.to_i + params.input2.to_i
      haml :about
    end
        
  #end of our module class WebApp
  end
end
