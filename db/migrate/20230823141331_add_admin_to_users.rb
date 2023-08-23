class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    # デフォルトでは管理ユーザーにはなれないようにする
    # 書かなくてもdefaultはnilになるが、明示的に示すことで意図が伝わりやすい
    add_column :users, :admin, :boolean, default: false
  end
end
