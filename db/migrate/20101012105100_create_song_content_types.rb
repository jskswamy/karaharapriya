class CreateSongContentTypes < ActiveRecord::Migration
  def self.up
    create_table :song_content_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :song_content_types
  end
end
