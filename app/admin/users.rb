ActiveAdmin.register User do
  config.filters = false # 一覧表示、編集のみ。検索、絞り込みはなし。

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :encrypted_password, :avatar, :reset_password_token, :reset_password_sent_at, :remember_created_at, :character_id, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :provider, :uid, :line_user_id, :credentials, :raw_info
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :encrypted_password, :avatar, :reset_password_token, :reset_password_sent_at, :remember_created_at, :character_id, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :provider, :uid, :line_user_id, :credentials, :raw_info]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
