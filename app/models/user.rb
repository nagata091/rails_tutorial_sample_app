class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  # before_saveは、モデルが保存される直前に実行されるコールバック
  before_save :downcase_email
  # bofore_createは、モデルが作成される直前に実行されるコールバック
  before_create :create_activation_digest

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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    # ダイジェストがnilの場合はfalseを返して早期脱出する
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーの情報を破棄するメソッド
  def forget
    # データベースのremember_digestをnilに更新する
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効化するメソッド
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # アカウント有効化用のメールを送信するメソッド
  def send_activation_email
    # ユーザー登録と同時にアカウントを有効化するメールを送信する
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定するメソッド
  def create_reset_digest
    # 22の長さのランダムな文字列を生成し、トークンとして返す
    self.reset_token = User.new_token
    # トークンをハッシュ化し、データベースのreset_digest属性に代入する
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # パスワード再設定用のメールを送信するメソッド
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返すメソッド
  def password_reset_expired?
    # パスワード再設定メールの送信時刻が、現在時刻より2時間以上前の場合はtrueを返す
    reset_sent_at < 2.hours.ago
  end

  private

    # メールアドレスをすべて小文字にする
    def downcase_email
      email.downcase!
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      # 22の長さのランダムな文字列を生成し、トークンとして返す
      self.activation_token = User.new_token
      # トークンをハッシュ化し、データベースのactivation_digest属性に代入する
      self.activation_digest = User.digest(activation_token)
    end
end
