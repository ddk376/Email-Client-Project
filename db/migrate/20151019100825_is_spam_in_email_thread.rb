class IsSpamInEmailThread < ActiveRecord::Migration
  def change
    add_column :email_threads, :is_spam, :boolean, default: false
  end
end
