require 'helper'

describe Uroborus::User do

  before do
    @subject = Uroborus::User.new
  end

  it 'should have a list of public_key' do
    @subject.must_respond_to :public_key
  end

  it 'should have a modulus' do
    @subject.must_respond_to :modulus
  end

  it 'should have an exponent' do
    @subject.must_respond_to :exponent
  end

  it 'should have a peer' do
    @subject.must_respond_to :peer
  end



end
