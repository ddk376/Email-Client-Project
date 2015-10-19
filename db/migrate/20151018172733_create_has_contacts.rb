class CreateHasContacts < ActiveRecord::Migration
  def change
    create_table :has_contacts do |t|
      t.integer :user_id
      t.integer :contact_id

      t.timestamps null: false
    end

    add_index :has_contacts, [:user_id, :contact_id]
  end
end
