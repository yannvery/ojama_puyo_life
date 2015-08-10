# spec/spec_helper.rb
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.order = 'random'
end
