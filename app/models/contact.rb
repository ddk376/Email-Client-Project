class Contact < ActiveRecord::Base
  belongs_to :user,
    class_name: 'User',
    foreign_key: :email,
    primary_key: :email

  has_many :sent_email_threads,
    class_name: 'EmailThread',
    foreign_key: :owner_id

  has_many :received,
    class_name: 'Recipient',
    foreign_key: :contact_id

  has_many :received_as_bcc,
    class_name: 'BccRecipient',
    foreign_key: :contact_id

  has_many :received_as_cc,
    class_name: 'CcRecipient',
    foreign_key: :contact_id

  has_many :received_emails,
    through: :received,
    source: :email

  has_many :emails_received_as_bcc,
    through: :received_as_bcc,
    source: :email

  has_many :emails_received_as_cc,
    through: :received_as_cc,
    source: :email

  has_many :been_in_contact_with, # not updated
    class_name: 'HasContact',
    foreign_key: :contact_id

end
