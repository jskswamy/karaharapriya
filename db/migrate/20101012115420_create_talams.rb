class CreateTalams < ActiveRecord::Migration
  def self.up
    create_table :talams do |t|
      t.string :name
      t.string :avartanam
      t.integer :laghu_length

      t.timestamps
    end
  end

  def self.down
    drop_table :talams
  end
end
