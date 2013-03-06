require 'rubygems'
require 'active_record'
require "uroborus/version"
require "uroborus/server"
require "uroborus/exec"

module Uroborus
  # Your code goes here...
end

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "db.sqlite3",
  :pool => 5,
  :timeout => 5000
)

#development:
#  adapter: sqlite3
#  database: db/development.sqlite3
#  pool: 5
#  timeout: 5000

