require 'drb'
require 'yaml'

class Uroborus::Server

  def initialize client
  end

  def self.port
    22783
  end

  def peers
    Uroborus::Peer.all.map{|p| p.address}
  end

  def add_peer address
    existing = Uroborus::Peer.find_by_address( address )
    Uroborus::Peer.new({:address => address}).save unless existing
  end

  def save key, chunk
  end

  def load key
  end


end

