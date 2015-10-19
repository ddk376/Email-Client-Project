# Schema Information

## email_threads
| column name | data type | details                  |
|-------------|:---------:|-------------------------:|
| subject     | string    |                          |
| owner_id    | integer   | null: false              |
| is_checked  | boolean   | default: false           |

## electronic_mails
| column name | data type | details                  |
|-------------|:---------:|-------------------------:|

## Recipients

## Bcc Recipients

## CC Recipients

## Attachments

## Conversation

## Message

## User


(subject: "Hello, I am sending a mail", body: "This is some body content", to: ["ddk376@gmail.com","greentea584@gmail.com"] )

(subject: "Hello, Part 2", body: "body content Part 2", to: ["ddk376@gmail.com","greentea584@gmail.com"] , to_bcc: ["ginajjeong@gmail.com", "greentea584@gmail.com"], to_cc: ["test@noofel.com"])


(subject: "Hello, Part 3", body: "body content Part 3", to: ["ddk376@gmail.com","greentea584@gmail.com"] , to_bcc: ["ginajjeong@gmail.com", "greentea584@gmail.com"], to_cc: ["test@noofel.com"])

User.create(email: "test@noofel.com", password: "password")
