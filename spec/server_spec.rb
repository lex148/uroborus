require 'helper'

describe Uroborus::Server do


  before do
    @subject = Uroborus::Server.new
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
    @subject = Uroborus::Server.new
    @subject.peers.must_include 'woot'
  end



end
