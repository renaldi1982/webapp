module WebApplication
  
  class ChatApp < Sinatra::Base    
    #register sinatra validation method so we can use our helpers function
    register Sinatra::SessionAuth
    register Sinatra::Query
    register Sinatra::ParamHashiefier
    register Sinatra::Flash
    helpers Sinatra::RedirectWithFlash    
    helpers Sinatra::JSON
    
     #enable sessions for login autentication
    enable :sessions
    
    #set path for layout and views
    set :haml, :layout => :'./../layout'
    set :views, Proc.new { File.join(root, "../views/chat") }
    
    helpers do      
      #def our helpers for chat client here
      def start_client(user)
        @@client = Jabber::Client.new(Jabber::JID.new("#{user.email}"))
        puts "client created for #{user.email}"
        @@client.connect("talk.google.com", 5222)
        puts "connected to google talk" 
        begin          
          @@client.auth(params.password_chat)                          
          puts "authenticated"
          @@client.send(Jabber::Presence.new.set_type(:available))
          puts "set status to available"
          roster unless !roster          
          listen                    
          
          json :msg => 'Authenticated', :state => 1, :time => "Time: #{Time.now.to_s}"          
        rescue Jabber::ClientAuthenticationFailure        
          puts "authentication failed"
          json :msg => 'Wrong passwords', :state => 0
        end
      end      
      
      def roster
        @@roster = Jabber::Roster::Helper.new(@@client)
        puts "roster created" unless !@@roster
        @@roster.items.each do |r|
          puts "#{r.to_s}"
        end
      end
            
      def send_msg         
        msg = Jabber::Message.new(session[:jid_send])        
        msg.body = params.input_chat
        msg.type = :chat
        if @@client                             
          @@client.send(msg)
          puts "successfuly send msg"          
          json :msg => "Message sent to #{session[:jid_send]} at #{Time.now.to_s}", :chat => "#{@@client.jid.to_s.split("/")[0]} says: #{params.input_chat}"
        else
          puts "client does not exist"
        end
      end
            
      def listen        
        @@client.add_message_callback do |m|
          if m.type != :error
            puts "listening to incoming message...."
            puts m.body            
          end
        end                
      end
      
    end
    
  end    
end