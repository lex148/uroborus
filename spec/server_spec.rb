require 'helper'
require 'rack/test'
set :environment, :test

describe Uroborus::Server do
  include Rack::Test::Methods

  def app
    Uroborus::Server
  end

  describe 'while logged in' do
    before do
      @saver_keys = RSA::KeyPair.generate(128)
      @saver      = @saver_keys.public_key
      @signed     = @saver_keys.sign '127.0.0.1'
      post '/login', params={ :key => @saver.to_a, :signed_server_ip => @signed }
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

    describe 'saving and loading' do

      before do
        @id ||= UUID.new.generate
        @data  = "TESTDATA"
        @owner = 'owners_super_public_key'
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

    end

  end


end


