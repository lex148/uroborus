require 'rubygems'
require 'active_support'
require 'active_record'
require "uroborus/version"
require "uroborus/server"
require "uroborus/models/peer"
require "uroborus/models/chunk"
require "uroborus/exec"

module Uroborus
  # Your code goes here...
end

#Dir["./uroborus/*.rb"].map{|t| t.match(/.\/(uroborus\/.*).rb/)[1]}.each{|file| require file}

env = ENV["RUBY_ENV"] || 'development'
ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "db/#{env}.sqlite3",
  :pool => 5,
  :timeout => 5000
)

Dir["./db/migrations/*.rb"].sort.each do |m|
  puts "running #{m}"
  require m
  klass = /\/[0-9]*_(.*)\.rb/.match(m)[1].classify.constantize
  begin
    migration = klass.new
    migration.change
  rescue
  end
end

