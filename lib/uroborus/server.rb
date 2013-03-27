require 'rubygems'
require 'sinatra'

use Rack::Session::Cookie, :secret => (0...50).map{ ('a'..'z').to_a[rand(26)] }.join

class Uroborus::Server < Sinatra::Base

  put '/save' do
    puts
    chunk = Uroborus::Chunk.find_or_create_by_global_id_and_owner_key( params[:id], params[:owner_key] )
    chunk.data = params[:data]
    chunk.save!
  end


  post '/load' do
    chunk = Uroborus::Chunk.find_by_global_id_and_owner_key( params[:id], params[:owner_key] )
    return nil unless chunk
    chunk.data
  end


  post '/login' do
    address = request.env["REMOTE_ADDR"]
    public_key = RSA::Key.new( params[:key][0], params[:key][1]  )
    return false unless public_key.valid?
    pair = RSA::KeyPair.new(nil, public_key)
    return false unless pair.verify(params[:signed_server_ip], address)
  end


end



