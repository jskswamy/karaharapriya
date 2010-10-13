class CreateSongContents < ActiveRecord::Migration
  def self.up
    create_table :song_contents do |t|
      t.integer :song_id
      t.integer :song_content_type_id
      t.string :body

      t.timestamps
    end
  end

  def self.down
    drop_table :song_contents
  end
end
