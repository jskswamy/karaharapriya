class AddDbIndexes < ActiveRecord::Migration
  def self.up
    add_index :ragams, :parent_id
    add_index :song_compositions, :song_type_id
    add_index :song_compositions, :song_content_type_id
    add_index :song_content_infos, :song_content_id
    add_index :song_content_infos, :info_id
    add_index :song_contents, :song_id
    add_index :song_contents, :song_content_type_id
    add_index :songs, :song_type_id
    add_index :songs, :composer_id
    add_index :songs, :ragam_id
    add_index :songs, :talam_id
  end

  def self.down
    remove_index :ragams, :parent_id
    remove_index :song_compositions, :song_type_id
    remove_index :song_compositions, :song_content_type_id
    remove_index :song_content_infos, :song_content_id
    remove_index :song_content_infos, :info_id
    remove_index :song_contents, :song_id
    remove_index :song_contents, :song_content_type_id
    remove_index :songs, :song_type_id
    remove_index :songs, :composer_id
    remove_index :songs, :ragam_id
    remove_index :songs, :talam_id
  end
end
