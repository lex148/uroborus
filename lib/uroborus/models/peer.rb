class Uroborus::Peer < ActiveRecord::Base

  has_and_belongs_to_many :chunks


  def connect
    self.rank = self.rank - 1
  end


end
