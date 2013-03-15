require 'helper'

describe Uroborus::Chunk do

  before do
    @subject = Uroborus::Chunk.new
  end

  it 'should know other location it is saved' do
    @subject.must_respond_to :peers
  end

end
