class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :email_id
      t.integer :contact_id

      t.timestamps null: false
    end

    add_index :recipients, [:email_id, :contact_id]
  end
end
