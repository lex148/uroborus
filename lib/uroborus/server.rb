require 'rubygems'
require 'sinatra'

class Uroborus::Server < Sinatra::Base
  use Rack::Session::Cookie, :secret => (0...50).map{ ('a'..'z').to_a[rand(26)] }.join


  put '/save' do
    throw(:halt, [401, "Not authorized\n"]) unless session[:current_user]
    chunk = Uroborus::Chunk.find_or_create_by_global_id_and_owner_key( params[:id], params[:owner_key] )
    chunk.data = params[:data]
    chunk.save!
  end


  post '/load' do
    throw(:halt, [401, "Not authorized\n"]) unless session[:current_user]
    chunk = Uroborus::Chunk.find_by_global_id_and_owner_key( params[:id], params[:owner_key] )
    return nil unless chunk
    chunk.data
  end


  post '/signout' do
    session[:current_user] = nil
  end

  post '/login' do
    address = request.env["REMOTE_ADDR"]
    user = Uroborus::User.find_or_create_by_modulus_and_exponent( params[:key][0].to_s, params[:key][1].to_s )
    if user.public_key.verify( params[:signed_server_ip], address )
      session[:current_user] = user
      return true
    end
    false
  end


end



