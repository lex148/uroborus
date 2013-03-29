require 'rubygems'
require 'sinatra'

class Uroborus::Server < Sinatra::Base

  set :show_exceptions, false
  use Rack::Session::Cookie, :secret => (0...50).map{ ('a'..'z').to_a[rand(26)] }.join

  def current_user
    session[:current_user]
  end


  put '/save' do
    throw(:halt, [401, "Not authorized\n"]) unless current_user
    modulus, exponent = *@saver.to_a
    owner = Uroborus::User.find_or_create_by_modulus_and_exponent( modulus.to_s, exponent.to_s )
    chunk = Uroborus::Chunk.find_or_create_by_global_id_and_owner_id( params[:id], owner.id )
    chunk.saver_id = current_user.id unless chunk.saver_id
    caller_id = current_user.id
    throw(:halt, [403, "Forbidden\n"]) unless chunk.owner_id == caller_id || chunk.saver_id == caller_id
    chunk.data = params[:data]
    chunk.save!
  end


  post '/load' do
    throw(:halt, [401, "Not authorized\n"]) unless current_user
    modulus, exponent = *@saver.to_a
    owner = Uroborus::User.find_or_create_by_modulus_and_exponent( modulus.to_s, exponent.to_s )
    chunk = Uroborus::Chunk.find_by_global_id_and_owner_id( params[:id], owner.id )
    return nil unless chunk
    caller_id = current_user.id
    throw(:halt, [403, "Forbidden\n"]) unless chunk.owner_id == caller_id || chunk.saver_id == caller_id
    chunk.data
  end


  post '/peers' do
    throw(:halt, [401, "Not authorized\n"]) unless current_user
    Uroborus::Peer.find(:all).sample(10).map{|p| [p.address, p.port ] }.uniq.to_json
  end


  post '/signout' do
    session[:current_user] = nil
  end


  post '/login' do
    address = request.env["REMOTE_ADDR"]
    user = Uroborus::User.find_or_create_by_modulus_and_exponent( params[:key][0].to_s, params[:key][1].to_s )
    user.peer = Uroborus::Peer.new unless user.peer
    user.peer.address = request.ip
    user.peer.port = params[:port]
    user.peer.save
    user.save
    if user.public_key.verify( params[:signed_server_ip], address )
      session[:current_user] = user
      return true
    end
    false
  end


end

