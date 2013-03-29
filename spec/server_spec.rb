require 'helper'
require 'rack/test'
set :environment, :test

describe Uroborus::Server do
  include Rack::Test::Methods
def app
    Uroborus::Server
  end

  describe 'without log in' do

    it "should not be able to save" do
        put "/save", params={:owner_key => @owner, :data => @data, :id => @id }
        last_response.status.must_equal 401
    end

    it "should not be able to load" do
        put "/save", params={:owner_key => @owner, :data => @data, :id => @id }
        last_response.status.must_equal 401
    end


  end

  describe 'while logged in' do
    before do
      @saver_keys = RSA::KeyPair.generate(128)
      @saver      = @saver_keys.public_key
      @signed     = @saver_keys.sign '127.0.0.1'
      @port       = 12345
      post '/login', params={ :key => @saver.to_a, :signed_server_ip => @signed, :port => @port }
    end

    it 'should authenticate a new user' do
      last_response.status.must_equal 200
    end

    it 'should authenticate a new user' do
      #binding.pry
      last_response.status.must_equal 200
    end

    it 'login should record a new user' do
      modulus, exponent = *@saver.to_a
      user = Uroborus::User.find_by_modulus_and_exponent( modulus.to_s, exponent.to_s )
      user.wont_be_nil
    end

    it 'should create a new peer for the new user' do
      modulus, exponent = *@saver.to_a
      user = Uroborus::User.find_by_modulus_and_exponent( modulus.to_s, exponent.to_s )
      user.peer.wont_be_nil
    end

    it 'should record the caller contact information in peer' do
      modulus, exponent = *@saver.to_a
      user = Uroborus::User.find_by_modulus_and_exponent( modulus.to_s, exponent.to_s )
      user.peer.address.must_equal '127.0.0.1'
      user.peer.port.must_equal @port
    end

    describe 'saving and loading' do

      before do
        @id ||= UUID.new.generate
        @data  = "TESTDATA"
        @owner = RSA::KeyPair.generate(128).public_key
      end

      it "should be able to save" do
        put "/save", params={:owner => @owner.to_a, :data => @data, :id => @id }
        last_response.status.must_equal 200
        Uroborus::Chunk.last.global_id.must_equal @id
        Uroborus::Chunk.last.data.must_equal @data
      end


      it "should be able to load" do
        put "/save", params={:owner => @owner.to_a, :data => @data, :id => @id }
        post '/load', params={ :id => @id, :owner_key => @owner }
        last_response.status.must_equal 200
        last_response.body.must_equal @data
      end


      it "should be able to be able to request more peers" do
        post "/peers"
        last_response.body.must_equal [ ['127.0.0.1',@port] ].to_json
      end


      it "should not let you access other users chunks" do
        put "/save", params={:owner => @owner.to_a, :data => @data, :id => @id }
        other = RSA::KeyPair.generate(128)
        signed     = other.sign '127.0.0.1'
        post '/login', params={ :key => other.public_key.to_a, :signed_server_ip => signed, :port => 12345 }
        post '/load', params={ :id => @id, :owner_key => @owner }
        last_response.status.must_equal 403
      end

      it "should not let you update other users chunks" do
        put "/save", params={:owner => @owner.to_a, :data => @data, :id => @id }
        other = RSA::KeyPair.generate(128)
        signed     = other.sign '127.0.0.1'
        post '/login', params={ :key => other.public_key.to_a, :signed_server_ip => signed, :port => 12345 }
        put "/save", params={:owner => @owner.to_a, :data => @data, :id => @id }
        last_response.status.must_equal 403
      end


    end

  end

end


