class CreateChunkTable < ActiveRecord::Migration

  def change

    create_table :chunks do |i|
      i.string :key
      i.binary :data
    end
  end

end
