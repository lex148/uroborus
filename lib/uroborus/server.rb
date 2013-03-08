require 'drb'
require 'yaml'

class Uroborus::Server

  def initialize client
    @peer = Uroborus::Peer.find_or_create_by_name client.name
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
    chunk.peer = @peer
    chunk.data = new_chunk.data
    !!chunk.save
  end

  def load key
    chunk = Uroborus::Chunk.where(:peer_id => @peer.id).find_by_key(key)
    chunk.nil? ? nil : chunk.data
  end


end

