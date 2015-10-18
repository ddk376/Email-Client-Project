class CreateEmailThreads < ActiveRecord::Migration
  def change
    create_table :email_threads do |t|
      t.string :subject
      t.integer :owner_id, null: false
      t.boolean :is_checked, default: false

      t.timestamps null: false
    end

    add_index :email_threads, :owner_id
  end
end
