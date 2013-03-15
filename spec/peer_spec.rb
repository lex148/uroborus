require 'helper'

describe Uroborus::Peer do

  before do
    @subject = Uroborus::Peer.new
  end

  it 'should have a list of chunks' do
    @subject.must_respond_to :chunks
  end

end
