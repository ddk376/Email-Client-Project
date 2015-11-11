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

  attr_reader :sent,:receivers, :bcc_receivers, :cc_receivers
  after_commit :add_recipients, on: [:create, :update]

  def to=(receiver_emails)
    @receivers = receiver_emails
  end

  def to_bcc=(receiver_emails)
    @bcc_receivers = receiver_emails
  end

  def to_cc=(receiver_emails)
    @cc_receivers = receiver_emails
  end

  def subject=(string)
    @subject_content = string
  end

  def sent=(value = false)
    @sent = value
    self.is_draft = false if @sent
  end

  def children
    user = User.current_user
    # debugger
    result = []
    children = self.children_emails
    children.each do |email|
      [email.recipients, email.bcc_recipients, email.cc_recipients].each do |recipient_table|
        result << email if recipient_table.any? { |recipient_entry| recipient_entry.contact_id == user.id } &&
                          !result.include?(email)
      end

      result << email if email.from == user.email && !result.include?(email)
    end

    result.uniq
  end

  private
  def add_recipients
    self.recipients.clear
    self.bcc_recipients.clear
    self.cc_recipients.clear
    count = 0
    [@receivers, @bcc_receivers, @cc_receivers].each do |receivers|
      receivers.each do |receiver_email|
        contact = Contact.find_by(email: receiver_email) || Contact.create(email: receiver_email)
        if count == 0
          self.recipients.create(contact_id: contact.id)
        elsif count == 1
          self.bcc_recipients.create(contact_id: contact.id)
        else
          self.cc_recipients.create(contact_id: contact.id)
        end
      end
      count += 1
    end
  end
  # def update_has_been_in_contact(emails)
  #   emails.each do |email|
  #     contact = Contact.find_by(email: email) || Contact.create(email: recipient_email)
  #     HasContact.create(user_id: self.sender.user.id, contact_id: contact.id)
  #   end if !emails.nil?
  # end

end
