require 'rubygems'
require 'bundler'
require 'xmpp4r/roster'
Bundler.require(:default)

require 'sinatra/json'
require 'digest/md5'

require_relative './models/init'
require_relative './helpers/init'
require_relative './applets/init'
require_relative './routes/init'

