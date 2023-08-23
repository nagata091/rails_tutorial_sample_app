class User < ApplicationRecord
  attr_accessor :remember_token
  # `before_save`は、モデルが保存される直前に実行されるコールバック
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
                       length: {minimum: 6},
                       # has_secure_passwordによって空のパスワードが新規登録の際に有効になることはない
                       allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 22の長さのランダムな文字列を生成し、トークンとして返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # ハッシュ化されたトークンを、永続的なセッションのためにデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    # update_attributeの結果を返すのではなく、remember_digestを返すようにする
    remember_digest
  end

  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  def session_token
    remember_digest || remember
  end

  # 渡されたトークンが、ダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    # ダイジェストがnilの場合はfalseを返して早期脱出する
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーの情報を破棄するメソッド
  def forget
    # データベースのremember_digestをnilに更新する
    update_attribute(:remember_digest, nil)
  end
end
