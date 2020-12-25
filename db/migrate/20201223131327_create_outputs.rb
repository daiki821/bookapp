class CreateOutputs < ActiveRecord::Migration[6.0]
  def change
    create_table :outputs do |t|
      t.references :user, null: false
      t.references :task, null: false
      t.text :content , null: false
      t.timestamps
    end
  end
end
