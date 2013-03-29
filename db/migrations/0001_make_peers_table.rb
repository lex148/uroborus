class MakePeersTable < ActiveRecord::Migration

  def change
    create_table :peers do |i|
      i.string   :address
      i.integer  :port
      i.integer  :rank, :null => false, :default => 0
    end
  end

end
