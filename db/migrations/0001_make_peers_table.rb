class MakePeersTable < ActiveRecord::Migration

  def change
    create_table :peers do |i|
      i.string :address
      i.string :name
      i.string :public_key
    end
  end

end
