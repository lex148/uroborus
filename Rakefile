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

Rake::TestTask.new(:console) do |test|
  #check_dependencies unless ENV['SKIP_DEP_CHECK']
  #ARGV.shift if ARGV.first == "pry"
  #ARGV.map! do |arg|
  #  arg.sub(/^_*/) { |m| "-" * m.size }
  #end
  require 'uroborus'
  require 'pry'
  Uroborus.pry
end

task :default => :test
