class Uroborus::User < ActiveRecord::Base

  belongs_to :peer

  def public_key
    key = RSA::Key.new( self.modulus.to_i, self.exponent.to_i )
    return false unless key.valid?
    RSA::KeyPair.new( nil, key )
  end


end
