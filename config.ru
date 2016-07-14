# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

# Action Cable requires that all classes are loaded in advance
Rails.application.eager_load!

use Rack::Cors do
  allow do
    origins 'localhost:8080', '127.0.0.1:8080',
            /\Ahttp:\/\/192\.168\.0\.\d{1,3}(:\d+)?\z/,
            'http://hubeert-webapp.herokuapp.com'
  end

  allow do
    origins '*'
    resource '*', :headers => :any, :methods => :any
  end
end

run Rails.application
