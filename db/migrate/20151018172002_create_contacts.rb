class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email_address

      t.timestamps null: false
    end
    add_index :contacts, :email_address
  end
end
