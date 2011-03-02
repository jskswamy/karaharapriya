# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'

SimpleCov.start 'rails'

SimpleCov.at_exit do
  SimpleCov.result.format!
  puts "Code coverage: #{SimpleCov.result.covered_percent.round(2)}%"
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require File.expand_path("../factories", __FILE__)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :each do
    Mongoid.database.collections.each do |collection|
      collection.remove unless collection.name.match(/^system\./)
    end
  end

  config.after(:suite) do
    #system("rails_best_practices")
  end
end
