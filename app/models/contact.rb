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

  has_many :received_threads,
    through: :received_emails,
    source: :email_thread

  has_many :bcc_threads,
    through: :emails_received_as_bcc,
    source: :email_thread

  has_many :cc_threads,
    through: :emails_received_as_cc,
    source: :email_thread

  def received_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  JOIN recipients r ON e.id = r.email_id
                  JOIN contacts rc ON r.contact_id = rc.id
                  JOIN bcc_recipients b ON e.id = b.email_id
                  JOIN contacts bc ON b.contact_id = bc.id
                  JOIN cc_recipients c ON e.id = c.email_id
                  JOIN contacts cc ON c.contact_id = cc.id
                  WHERE (rc.email = '#{self.email}'
                  OR bc.email = '#{self.email}'
                  OR cc.email = '#{self.email}')
                  AND t.is_trash = false
                  AND t.is_spam = false")
  end

  def sent_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  WHERE e.from = '#{self.email}'
                  AND e.is_draft = false
                  AND t.is_trash = false
                  AND t.is_spam = false")
  end

  def draft_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  WHERE e.from = '#{self.email}'
                  AND e.is_draft = true
                  AND t.is_trash = false
                  AND t.is_spam = false")
  end

  def starred_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  JOIN recipients r ON e.id = r.email_id
                  JOIN contacts rc ON r.contact_id = rc.id
                  JOIN bcc_recipients b ON e.id = b.email_id
                  JOIN contacts bc ON b.contact_id = bc.id
                  JOIN cc_recipients c ON e.id = c.email_id
                  JOIN contacts cc ON c.contact_id = cc.id
                  WHERE (rc.email = '#{self.email}'
                  OR bc.email = '#{self.email}'
                  OR cc.email = '#{self.email}')
                  AND t.is_trash = false
                  AND t.is_spam = false
                  AND e.is_starred = true") + EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  WHERE e.from = '#{self.email}'
                  AND e.is_draft = false
                  AND t.is_trash = false
                  AND t.is_spam = false
                  AND e.is_starred = true")
  end

  def important_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  JOIN recipients r ON e.id = r.email_id
                  JOIN contacts rc ON r.contact_id = rc.id
                  JOIN bcc_recipients b ON e.id = b.email_id
                  JOIN contacts bc ON b.contact_id = bc.id
                  JOIN cc_recipients c ON e.id = c.email_id
                  JOIN contacts cc ON c.contact_id = cc.id
                  WHERE (rc.email = '#{self.email}'
                    OR bc.email = '#{self.email}'
                    OR cc.email = '#{self.email}')
                    AND t.is_trash = false
                    AND t.is_spam = false
                    AND t.is_important = true") + EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  WHERE e.from = '#{self.email}' AND e.is_draft = false AND t.is_trash = false AND t.is_spam = false AND t.is_important = true")
  end

  def trash_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  JOIN recipients r ON e.id = r.email_id
                  JOIN contacts rc ON r.contact_id = rc.id
                  JOIN bcc_recipients b ON e.id = b.email_id
                  JOIN contacts bc ON b.contact_id = bc.id
                  JOIN cc_recipients c ON e.id = c.email_id
                  JOIN contacts cc ON c.contact_id = cc.id
                  WHERE (rc.email = '#{self.email}'
                  OR bc.email = '#{self.email}'
                  OR cc.email = '#{self.email}')
                  AND t.is_trash = true") + EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  WHERE e.from = '#{self.email}' AND t.is_trash = true")
  end

  def all_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  JOIN recipients r ON e.id = r.email_id
                  JOIN contacts rc ON r.contact_id = rc.id
                  JOIN bcc_recipients b ON e.id = b.email_id
                  JOIN contacts bc ON b.contact_id = bc.id
                  JOIN cc_recipients c ON e.id = c.email_id
                  JOIN contacts cc ON c.contact_id = cc.id
                  WHERE rc.email = '#{self.email}'
                  OR bc.email = '#{self.email}'
                  OR cc.email = '#{self.email}'") + EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  WHERE e.from = '#{self.email}'")
  end

  def spam_threads
    EmailThread.find_by_sql("SELECT
                    *
                  FROM
                    email_threads t
                  JOIN electronic_mails e ON t.id = e.email_thread_id
                  JOIN recipients r ON e.id = r.email_id
                  JOIN contacts rc ON r.contact_id = rc.id
                  JOIN bcc_recipients b ON e.id = b.email_id
                  JOIN contacts bc ON b.contact_id = bc.id
                  JOIN cc_recipients c ON e.id = c.email_id
                  JOIN contacts cc ON c.contact_id = cc.id
                  WHERE (rc.email = '#{self.email}'
                  OR bc.email = '#{self.email}'
                  OR cc.email = '#{self.email}')
                  AND t.is_trash = false
                  AND t.is_spam = true")
  end

end
