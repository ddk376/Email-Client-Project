class EmailThread < ActiveRecord::Base
  belongs_to :author, #needs to be tested
   class_name: 'Contact',
   foreign_key: :owner_id

  has_many :emails, #not working
    class_name: 'ElectronicMail',
    foreign_key: :email_thread_id,
    dependent: :destroy

end
