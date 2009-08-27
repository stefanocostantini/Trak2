class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :completeness
      t.boolean :now
      t.boolean :later
      t.boolean :archived
      t.integer :user_id
      t.integer :project_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
