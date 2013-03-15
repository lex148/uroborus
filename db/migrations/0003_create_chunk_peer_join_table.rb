class CreateChunkPeerJoinTable < ActiveRecord::Migration

  def change

    create_table :chunks_peers, :id => false do |i|
      i.integer :chunk_id
      i.integer :peer_id
    end

  end

end
