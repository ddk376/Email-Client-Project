class ChangeContactTable < ActiveRecord::Migration
  def change
    remove_column :contacts, :email_address
    add_column :contacts, :email, :string, null: false
    add_index :contacts, :email, unique: true
  end
end
