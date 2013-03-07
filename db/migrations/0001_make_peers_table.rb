class MakePeersTable < ActiveRecord::Migration

  def change
    create_table :peers do |i|
      i.string :address
    end
  end

end
