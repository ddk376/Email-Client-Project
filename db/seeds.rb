# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user1 = User.create({email:"test1@noofel.com", password: "password"}).associated_contact_info
user2 = User.create({email:"test2@noofel.com", password: "password"}).associated_contact_info
user3 = User.create({email:"test3@noofel.com", password: "password"}).associated_contact_info

email1 = user1.sent_email_threads.create(id: 1, subject: "hello", is_checked: false, is_archived: false, is_trash: false, is_important: false).emails.create(from: user1.email, body: "Some body content", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["ddk376@gmail.com"], to_bcc: ["test2@noofel.com"], to_cc: ["test3.noofel.com"])
email2 = user2.sent_email_threads.create(id: 2, subject: "What's up", is_checked: false, is_archived: false, is_trash: false, is_important: false).emails.create(from: user2.email, body: "Some body content", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["test1@noofel.com", "ddk376@gmail.com"], to_bcc: ["test2@noofel.com"], to_cc: ["test3.noofel.com"])
email3 = user3.sent_email_threads.create(id: 3, subject: "hello Part 2", is_checked: false, is_archived: false, is_trash: false, is_important: false).emails.create(from: user3.email, body: "Some body content", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["test3@noofel.com"], to_bcc: ["test2@noofel.com"], to_cc: [])

thread1 = EmailThread.find(1)
thread2 = EmailThread.find(2)

thread1.emails.first.children_emails.create(email_thread_id: 1, from: user2.email, body: "Response to some body content", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["test1@noofel.com"], to_bcc: ["test2@noofel.com"], to_cc: ["test3.noofel.com"])
thread2.emails.first.children_emails.create(email_thread_id: 2, from: "test1@noofel.com", body: "kakajlksjfjsafl", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["test2@noofel.com", "ddk376@gmail.com"], to_bcc: ["test2@noofel.com"], to_cc: ["test3.noofel.com"])

email4 = user2.sent_email_threads.create(id: 4, subject: "Hello, Part 2", is_checked: false, is_archived: false, is_trash: false, is_important: false).emails.create(email_thread_id: 4, from: user2.email, body: "Some body content Part 2", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["test1@noofel.com"], to_bcc: [], to_cc: [])
email5 = user3.sent_email_threads.create(id: 5, subject: "hello Part 3", is_checked: false, is_archived: false, is_trash: false, is_important: false).emails.create(email_thread_id: 5,from: user3.email, body: "Would you like to build a snowman", is_starred: false, is_draft: false, is_read: false, sent: true, to: ["test1@noofel.com"], to_bcc: [], to_cc: [])
