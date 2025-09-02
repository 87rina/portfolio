class AddAgeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :line_user_id, :string
    add_column :users, :credentials, :json
    add_column :users, :raw_info, :json
  end
end
