require 'rubygems'
require 'bundler'
require 'xmpp4r/roster'
Bundler.require(:default)

<<<<<<< HEAD
require 'sinatra/json'
require 'digest/md5'

=======
require 'digest/md5'

require_relative './helpers/init'
>>>>>>> 639cc153cc5157a8527b2f6e2934d32995abad57
require_relative './models/init'
require_relative './helpers/init'
require_relative './applets/init'
require_relative './routes/init'

