class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :name
      t.string :composer
      t.integer :song_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :songs
  end
end
