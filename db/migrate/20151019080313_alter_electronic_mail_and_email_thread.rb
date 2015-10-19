class AlterElectronicMailAndEmailThread < ActiveRecord::Migration
  def change
    remove_column :electronic_mails, :is_archived
    remove_column :electronic_mails, :is_trash
    remove_column :electronic_mails, :is_important

    add_column :email_threads, :is_archived, :boolean, default: false
    add_column :email_threads, :is_trash, :boolean, default: false
    add_column :email_threads, :is_important, :boolean, default: false
  end
end
