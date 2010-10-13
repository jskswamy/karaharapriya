class CreateRagams < ActiveRecord::Migration
  def self.up
    create_table :ragams do |t|
      t.string :name
      t.string :arohana
      t.string :avarohana
      t.boolean :major
      t.integer :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ragams
  end
end
