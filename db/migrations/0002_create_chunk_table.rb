class CreateChunkTable < ActiveRecord::Migration

  def change

    create_table :chunks do |i|
      i.integer  :owner_id
      i.integer  :saver_id
      i.string   :global_id
      i.binary   :data
    end
  end

end
