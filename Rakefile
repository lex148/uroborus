require "bundler/gem_tasks"
require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |test|
  File.delete("db/test.sqlite3") if File.exists?( "db/test.sqlite3" )
  ENV["RUBY_ENV"] = 'test'
  test.libs << 'lib' << 'spec'
  test.pattern = './spec/**/*_spec.rb'
  test.verbose = true
end

task :pry do |test|
  require 'uroborus'
  require 'pry'
  Uroborus.pry
end

task :server do |test|
  require 'uroborus'
  Uroborus::Exec.start_server
end

task :default => :test
