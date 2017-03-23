require "bundler/gem_tasks"
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task :spec => 'ci:setup:rspec'

task :default => [:spec, :build]
