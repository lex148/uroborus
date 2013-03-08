require 'helper'

describe Uroborus::Server do

  def reload_subject
    @subject = Uroborus::Server.new @client
  end


  before do
    @client = Uroborus::Peer.create({:name => 'lex148'})
    @chunk = Uroborus::Chunk.new(:key => "1", :data => "woot")
    @subject = Uroborus::Server.new @client
  end


  it 'should have a port' do
    Uroborus::Server.port.wont_be_nil
  end

  it 'should have a list of peers' do
    @subject.peers.must_be_instance_of Array
  end

  it 'should be able to add peers' do
    @subject.add_peer 'woot'
    @subject.peers.must_include 'woot'
  end

  it 'should save the peer list' do
    @subject.add_peer 'woot'
    reload_subject
    @subject.peers.must_include 'woot'
  end

  it 'should be able to save a chunk' do
    @subject.save @chunk
    reload_subject
    @subject.load(@chunk.key).must_equal @chunk.data
  end

  it 'should scope chunk per peer' do
    @subject.save @chunk
    @subject = Uroborus::Server.new Uroborus::Peer.create
    @subject.load(@chunk.key).must_be_nil
  end

end
