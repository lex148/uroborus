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
    !!Uroborus::Peer.new({:address => address}).save unless existing
  end

  def save new_chunk
    chunk = Uroborus::Chunk.find_or_create_by_key( new_chunk.key )
    chunk.data = new_chunk.data
    !!chunk.save
  end

  def load key
    Uroborus::Chunk.find_by_key(key).data
  end


end

