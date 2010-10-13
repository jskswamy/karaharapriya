class CreateSongCompositions < ActiveRecord::Migration
  def self.up
    create_table :song_compositions do |t|
      t.integer :song_type_id
      t.integer :song_content_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :song_compositions
  end
end
