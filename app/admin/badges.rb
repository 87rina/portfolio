ActiveAdmin.register Badge do
  config.filters = false # 一覧表示、編集のみ。検索、絞り込みはなし。
  permit_params :name, :description, :condition, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :condition
      f.input :threshold
      f.input :image, as: :file
    end
    f.actions
  end
end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :condition
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :condition]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
