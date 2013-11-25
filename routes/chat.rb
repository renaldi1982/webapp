module WebApplication
  class ChatApp < Sinatra::Base
    
    get '/' do
      puts "enter get /"
      authorize!
     
      haml :chat                         
    end
    
    get '/:id' do
      puts "enter get /:id"
      authorize!
      @id = params.id
      redirect '/chat', :notice => "Chat session for #{current_user.username.capitalize}"            
    end
        
    post '/connect' do 
      puts "enter /chat/connect post"
      authorize!    
      start_client(current_user)                                              
    end   
    
    post '/send' do      
      session[:jid_send] = params.input_send unless session[:jid_send] || !params.input_send.nil?
      puts "#{session[:jid_send]}"
      puts "enter /chat/send post"
      authorize!     
      send_msg()           
    end
    
  end  
end