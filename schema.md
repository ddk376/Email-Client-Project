# Schema Information

## email_threads
| column name    | data type | details                  |
|----------------|:---------:|-------------------------:|
| subject        | string    |                          |
| owner_id       | integer   | null: false              |
| is_checked     | boolean   | default: false           |
| is_important   | boolean   | default: false           |
| is_archived    | boolean   | default: false           |
| is_trash       | boolean   | default: false           |
| is_spam        | boolean   | default: false           |

## electronic_mails
| column name     | data type | details                  |
|-----------------|:---------:|-------------------------:|
| email_thread_id | integer   | null: false              |
| parent_email_id | integer   |                          |
| from            | string    | null: false              |
| body            | text      |                          |
| is_starred      | boolean   | default: false           |
| is_draft        | boolean   | default: false           |
| is_read         | boolean   | default: false           |

## contacts
| column name    | data type | details                  |
|----------------|:---------:|-------------------------:|
| email          | string    | null: false              |

## recipients
| column name    | data type | details                  |
|----------------|:---------:|-------------------------:|
| email_id       | integer   |                          |
| contact_id     | integer   |                          |

## bcc_recipients
| column name    | data type | details                  |
|----------------|:---------:|-------------------------:|
| email_id       | integer   |                          |
| contact_id     | integer   |                          |

## cc_recipients
| column name    | data type | details                  |
|----------------|:---------:|-------------------------:|
| email_id       | integer   |                          |
| contact_id     | integer   |                          |

## has_contacts
| column name    | data type | details                  |
|----------------|:---------:|-------------------------:|
| user_id        | integer   |                          |
| contact_id     | integer   |                          |

## Attachments

## Conversation

## Message

## User
| column name     | data type | details                  |
|-----------------|:---------:|-------------------------:|
| email           | string    | null: false              |
| password_digest | string    | null: false              |
| session_token   | string    | null: false              |
