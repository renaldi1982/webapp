require './app'
root = File.dirname(__FILE__) 
# setup our Rack routes to pass control on to Sinatra
Routes = Rack::Mount::RouteSet.new do |set|
  # provides a route to the Main applet
  set.add_route WebApplication::WebApp,
    { :path_info => %r{^/*} }, {}, :main
  # provides a route to all the static assets (JS, CSS, images, etc...)
  set.add_route Rack::File.new(File.join(root, 'public')),
    { :path_info => %r{^/public*} }, {}, :public
end

# finally, run Rack with our previously define routes
run Routes
