class CreateUsersTable < ActiveRecord::Migration

  def change
    create_table :users do |i|
      i.string   :modulus
      i.string   :exponent
      i.string   :last_ip
      i.string   :last_port
      i.integer  :peer_id
    end
  end

end
