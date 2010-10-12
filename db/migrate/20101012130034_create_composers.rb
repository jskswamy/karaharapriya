class CreateComposers < ActiveRecord::Migration
  def self.up
    create_table :composers do |t|
      t.string :name
      t.string :century
      t.string :info

      t.timestamps
    end
  end

  def self.down
    drop_table :composers
  end
end
