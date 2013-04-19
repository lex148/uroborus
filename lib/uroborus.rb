require 'rubygems'
require "uuid"
require "rsa"
require 'active_support'
require 'active_record'
require "uroborus/version"
require "uroborus/server"
require "uroborus/models/user"
require "uroborus/models/peer"
require "uroborus/models/chunk"
require "uroborus/exec"
require 'yaml'

module Uroborus
end


env = ENV["RUBY_ENV"] || 'development'
db = YAML::load_file('./config/database.yml')[env]
puts db
ActiveRecord::Base.establish_connection( db )

#Run all migrations
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

