class MakePeersTable < ActiveRecord::Migration

  def change
    create_table :peers do |i|
      i.string   :address
      i.string   :public_key
      i.integer  :rank, :null => false, :default => 0
    end
  end

end
