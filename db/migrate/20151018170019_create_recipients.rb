class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.integer :email_id
      t.string :email

      t.timestamps null: false
    end

    add_index :recipients, [:email_id, :email]
  end
end
