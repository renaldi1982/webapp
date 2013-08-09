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
    end
  end
  
  task :drop do
    puts "Dropping table users..."
    DB.drop_table?(:users)
  end
  
  task :rebuild => [:drop, :create] do
    puts "Database rebuilt!"
  end
end
