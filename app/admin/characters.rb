ActiveAdmin.register Character do
  config.filters = false #一覧表示、編集のみ。検索、絞り込みはなし。

  form do |f|
    f.inputs do
      f.input :name
      f.input :system_prompt
      f.input :image, as: :file  # 画像アップロード可能
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :system_prompt, :image_url
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :system_prompt, :image_url]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
