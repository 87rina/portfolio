class RemoveImageUrlFromCharacters < ActiveRecord::Migration[7.2]
  def change
    remove_column :characters, :image_url, :string
  end
end
