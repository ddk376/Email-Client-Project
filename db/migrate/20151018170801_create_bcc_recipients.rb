class CreateBccRecipients < ActiveRecord::Migration
  def change
    create_table :bcc_recipients do |t|
      t.integer :email_id
      t.integer :contact_id

      t.timestamps null: false
    end
    add_index :bcc_recipients, [:email_id, :contact_id]
  end
end
