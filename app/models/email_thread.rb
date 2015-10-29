class EmailThread < ActiveRecord::Base
  belongs_to :author,
   class_name: 'Contact',
   foreign_key: :owner_id

  has_many :emails,
    class_name: 'ElectronicMail',
    foreign_key: :email_thread_id,
    dependent: :destroy

  def parent_email
    self.emails.select {|email| email.parent_email_id == nil }.first
  end

end
