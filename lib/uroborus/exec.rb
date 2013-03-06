require 'drb'

module Uroborus::Exec

  def start_server

    DRb.start_service "druby://:#{Uroborus::Server.port}", Uroborus::Server.new
    puts "Server running at #{DRb.uri}"
    trap("INT") { DRb.stop_service }
    DRb.thread.join

  end

  module_function :start_server

end
