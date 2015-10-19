class AlterRecipient < ActiveRecord::Migration
  def change
    drop_table :recipients

    create_table :recipients do |t|
      t.integer :email_id
      t.integer :contact_id

      t.timestamps null: false
    end

    add_index :recipients, [:email_id, :contact_id]
  end
end
