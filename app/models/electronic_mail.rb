class ElectronicMail < ActiveRecord::Base
  validates :email_thread_id, presence: true
  validates :from, presence: true

  belongs_to :email_thread,
    class_name: 'EmailThread',
    foreign_key: :email_thread_id,
    dependent: :destroy

  belongs_to :sender,
    class_name: 'Contact',
    foreign_key: :from,
    primary_key: :email

  has_many :recipients,
    class_name: 'Recipient',
    foreign_key: :email_id

  has_many :bcc_recipients,
    class_name: 'BccRecipient',
    foreign_key: :email_id

  has_many :cc_recipients,
    class_name: 'CcRecipient',
    foreign_key: :email_id

  has_many :send_to, through: :recipients, source: :contact
  has_many :bcc, through: :bcc_recipients, source: :contact
  has_many :cc, through: :cc_recipients, source: :contact

  belongs_to :parent_email,
    class_name: 'ElectronicMail',
    dependent: :destroy

  has_many :children_emails,
    class_name: 'ElectronicMail',
    foreign_key: :parent_email_id,
    dependent: :destroy

  attr_reader :sent

  def to=(receiver_emails)
    # update_has_been_in_contact(receiver_emails) if @sent
    self.recipients.clear # should be able to optimize this
    receiver_emails.each do |recipient_email|
      contact = Contact.find_by(email: recipient_email) || Contact.create(email: recipient_email)
      self.recipients.new(contact_id: contact.id)
    end
  end

  def to_bcc=(bcc_receivers)
    # update_has_been_in_contact(bcc_receivers) if @sent
    self.recipients.clear
    bcc_receivers.each do |recipient_email|
      contact = Contact.find_by(email: recipient_email) || Contact.create(email: recipient_email)
      self.bcc_recipients.new(contact_id: contact.id)
    end if !bcc_receivers.nil?
  end

  def to_cc=(cc_receivers)
    # update_has_been_in_contact(cc_receivers) if @sent
    self.recipients.clear
    cc_receivers.each do |recipient_email|
      contact = Contact.find_by(email: recipient_email) || Contact.create(email: recipient_email)
      self.cc_recipients.new(contact_id: contact.id)
    end if !cc_receivers.nil?
  end

  def subject=(string)
    @subject_content = string
  end

  def sent=(value = false)
    @sent = value
    self.is_draft = false if @sent
  end

  # def update_has_been_in_contact(emails)
  #   emails.each do |email|
  #     contact = Contact.find_by(email: email) || Contact.create(email: recipient_email)
  #     HasContact.create(user_id: self.sender.user.id, contact_id: contact.id)
  #   end if !emails.nil?
  # end

end
