# Set the environment variables for the test app
ENV[ 'RAILS_ENV' ] = 'test'

# Add the test app to the load path
$: << ENV[ 'BALDWIN_RAILS_PATH' ]

# Require all dependencies
Bundler.require

# Boot the rails app
require 'config/environment'
