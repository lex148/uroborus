require 'drb'
require 'yaml'

class Uroborus::Server

  attr_reader :peers

  def initialize
    @peers = []
  end

  def self.port
    22783
  end

  def add_peer peer
    @peers << peer
  end



end

