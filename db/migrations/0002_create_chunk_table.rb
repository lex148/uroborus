class CreateChunkTable < ActiveRecord::Migration

  def change

    create_table :chunks do |i|
      i.string :owner_key
      i.string :global_id
      i.binary :data
    end
  end

end
