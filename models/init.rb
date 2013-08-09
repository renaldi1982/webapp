# connect w/ sequel to our sqlite DB (remember, sqlite is just our adapter to the backend DB, so
# we could just as easily use MySQL, PostgreSQL, etc))
DB=Sequel.connect('sqlite://data.db')

# require our models to interface with our DB tables
require_relative './user'
