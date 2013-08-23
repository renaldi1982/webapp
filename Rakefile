require './app'

namespace :db do
  task :create do
    puts "Creating table users..."
    DB.create_table(:users) do
      primary_key :id
      String :username,         :unique => true
      String :password
      String :email
      String :first_name
      String :last_name
      Boolean :admin
    end
  end
  
  task :drop do
    puts "Dropping table users..."
    DB.drop_table?(:users)
  end
  
  task :rebuild => [:drop, :create] do
    puts "Database rebuilt!"
  end
  
  task :seed do
    User.create(:username => "renaldi", :password => "5f4dcc3b5aa765d61d8327deb882cf99",
    :email => "renaldi.sim@gmail.com", :first_name => "Renaldi", :last_name => "Kosim", :admin => true)
  end
    
end
