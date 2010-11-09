class AddRagamAndTalamToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :ragam_id, :integer
    add_column :songs, :talam_id, :integer
  end

  def self.down
    remove_column :songs, :talam_id
    remove_column :songs, :ragam_id
  end
end
