class User < ApplicationRecord
  before_save {self.email = self.email.downcase}
                   # 存在性の検証
  validates :name, presence: true,
                   # 長さの検証
                   length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: {maximum: 255},
                    # フォーマットの検証。メールアドレスの正規表現を使っている
                    format: {with: VALID_EMAIL_REGEX},
                    # 一意性の検証。大文字小文字は無視する
                    uniqueness: true
  has_secure_password
  validates :password, presence: true,
                       length: {minimum: 6}
end
