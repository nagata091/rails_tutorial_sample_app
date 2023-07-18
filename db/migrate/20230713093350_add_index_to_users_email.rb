class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    # usersテーブルのemailカラムに、一意性を強制して追加する。
    add_index :users, :email, unique: true
  end
end
