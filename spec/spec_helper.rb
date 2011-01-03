require 'rubygems'
#require 'spork'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  RSpec.configure do |config|
    config.include Devise::TestHelpers, :type => :controller
  end
  
  RSpec.configure do |config|
    config.extend ControllerMacros, :type => :controller
  end
    
  include Rails.application.routes.url_helpers
  Devise::OmniAuth.test_mode!
  
  ### Part of a Spork hack. See http://bit.ly/arY19y
  # Emulate initializer set_clear_dependencies_hook in 
  # railties/lib/rails/application/bootstrap.rb
  # ActiveSupport::Dependencies.clear
  
end

#Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
#  ENV["RAILS_ENV"] ||= 'test'
#  unless defined?(Rails)
#    require File.dirname(__FILE__) + "/../config/environment"
#  end
#  require 'rspec/rails'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
#  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
#end

#Spork.each_run do
  # This code will be run each time you run your specs.
#end
