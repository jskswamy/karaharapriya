class CreateSongContentInfos < ActiveRecord::Migration
  def self.up
    create_table :song_content_infos do |t|
      t.integer :song_content_id
      t.integer :info_id
      t.string :info_type

      t.timestamps
    end
  end

  def self.down
    drop_table :song_content_infos
  end
end
