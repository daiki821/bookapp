class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.date :completed_at, null: false
      t.boolean :completed , null: false, default: false
      t.timestamps
    end
  end
end
