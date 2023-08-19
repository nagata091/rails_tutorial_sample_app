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

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
