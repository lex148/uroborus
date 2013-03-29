require 'helper'

describe Uroborus::Chunk do

  before do
    @subject = Uroborus::Chunk.new
  end

  it 'should know other location it is saved' do
    @subject.must_respond_to :peers
  end

  it 'should know its owner' do
    @subject.must_respond_to :owner_id
  end

  it 'should know its saver' do
    @subject.must_respond_to :saver_id
  end


end
