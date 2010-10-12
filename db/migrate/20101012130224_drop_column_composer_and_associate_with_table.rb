class DropColumnComposerAndAssociateWithTable < ActiveRecord::Migration
  def self.up
    remove_column :songs, :composer
    add_column :songs, :composer_id, :integer
  end

  def self.down
    add_column :songs, :composer, :string
    remove_column :songs, :composer_id
  end
end
