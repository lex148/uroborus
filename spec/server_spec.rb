require 'helper'

describe Uroborus::Server do


  before do
    @client = Object.new
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
    @subject = Uroborus::Server.new @client
    @subject.peers.must_include 'woot'
  end

  it 'should be able to save a chunk' do
    @subject.save 1,"chunk"
    @subject = Uroborus::Server.new @client
    @subject.load(1).must_equal "chunk"
  end


end
