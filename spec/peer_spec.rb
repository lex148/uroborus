require 'helper'

describe Uroborus::Peer do

  before do
    @subject = Uroborus::Peer.new
  end

  it 'should have a list of chunks' do
    @subject.must_respond_to :chunks
  end

  it 'should have a public_key' do
    @subject.must_respond_to :public_key
  end

  it 'should have a ranking' do
    @subject.must_respond_to :rank
  end

  it 'should have an address' do
    @subject.must_respond_to :address
  end

  it 'should respond to connect' do
    @subject.must_respond_to :connect
  end

  it 'should have an starting rank' do
    @subject.rank.wont_be_nil
  end

  it 'should be deranked if connection failed' do
    rank = @subject.rank
    @subject.connect
    @subject.rank.must_be "<".to_sym, rank
  end





end
