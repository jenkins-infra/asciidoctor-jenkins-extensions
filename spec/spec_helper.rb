require 'rspec'
require 'rspec/its'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib'))

RSpec.configure do |c|
  c.color = true
end
