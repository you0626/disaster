# テーブル設計

## Users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| name               | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| last_login_at      | datetime | null: false               |

### Association

- has_many :friendships
- has_many :posts
- has_many :disaster_notifications
- has_many :shelters
- has_many :supplys

## Friendships テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user_id   | references | null: false, foreign_key: true |
| friend_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :friend, class_name: 'User'

## Posts テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user_id  | references | null: false, foreign_key: true |
| content  | text       | null: false                    |

### Association

- belongs_to :user

## DisasterNotifications テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| message | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## Shelters テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| location    | text       | null: false                    |
| description | text       |                                |
| user_id     | references | null: false, foreign_key: true |

### Association

- belongs_to :user

## Supplys テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| expiration_date | date       | null: false                    |
| user_id         | references | null: false, foreign_key: true |

### Association

- belongs_to :user