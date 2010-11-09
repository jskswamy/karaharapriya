class AddDescriptionToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :description, :string
  end

  def self.down
    remove_column :songs, :description
  end
end
