require 'helper'
require 'rack/test'
set :environment, :test

describe Uroborus::Server do
  include Rack::Test::Methods

  before do
    @id ||= UUID.new.generate
    @data = "TESTDATA"
    @owner = 'owners_super_public_key'
    #@saver_keys = RSA::KeyPair.generate(3072)
    @saver_keys = RSA::KeyPair.generate(128)
    @saver = @saver_keys.public_key
  end

  def app
    Uroborus::Server
  end

  it "should be able to save" do
    put "/save", params={:owner_key => @owner, :data => @data, :id => @id }
    last_response.status.must_equal 200
    Uroborus::Chunk.last.global_id.must_equal @id
    Uroborus::Chunk.last.data.must_equal @data
  end


  it "should be able to load" do
    put "/save", params={:owner_key => @owner, :data => @data, :id => @id }
    post '/load', params={ :id => @id, :owner_key => @owner }
    last_response.status.must_equal 200
    last_response.body.must_equal @data
  end

  it 'should authenticate a new user' do
    signed = @saver_keys.sign '127.0.0.1'
    post '/login', params={ :key => @saver.to_a, :signed_server_ip => signed }
    last_response.status.must_equal 200
  end

  it 'login should record a new user' do
    signed = @saver_keys.sign '127.0.0.1'
    key = @saver.to_a
    post '/login', params={ :key => key, :signed_server_ip => signed }
    Uroborus::User.all.size.must_equal 1
    user = Uroborus::User.find_by_modulus_and_exponent( key[0].to_s, key[1].to_s )
    user.wont_be_nil
  end

  #it 'should add you to the peers list when you save a chunk' do
  #  put "/save", params={:owner_key => @owner, :data => @data, :id => @id }
  #  Uroborus::Peer.all.size.must_equal 1
  #end


  #it "should be able to tell you about other peers" do
  #  post '/peers'
  #  last_response.status.must_equal 200
  #  last_response.body.must_equal []
  #end


end


