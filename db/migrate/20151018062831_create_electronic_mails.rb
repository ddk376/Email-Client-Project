class CreateElectronicMails < ActiveRecord::Migration
  def change
    create_table :electronic_mails do |t|
      t.references :email_thread, null: false
      t.integer :parent_email_id
      t.string :from, null: false
      t.text :body
      t.boolean :is_important, default: false
      t.boolean :is_starred, default: false
      t.boolean :is_draft, default: false
      t.boolean :is_trash, default: false
      t.boolean :is_archived, default: false
      t.boolean :is_read, default: false

      t.timestamps null: false
    end
  end
end
