module Sinatra
  module ParamHashiefier
    
    def self.registered(app)
      app.before do
        @params = Hashie::Mash.new(params)
      end
    end
    
  end
end