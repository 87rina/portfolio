class MigrateCharacterImagesToActiveStorage < ActiveRecord::Migration[7.2]
  def up
    Character.find_each do |character|
      next if character.image.attached? || character.image_url.blank?

      # 旧カラムからファイルパスを組み立てる
      file_path = Rails.root.join("app/assets/images", character.image_url)

      if File.exist?(file_path)
        character.image.attach(
          io: File.open(file_path),
          filename: File.basename(file_path)
        )
      else
        Rails.logger.warn "画像が見つかりません: #{file_path}"
      end
    end
  end

  def down
    # ActiveStorageデータを削除する（必要なら）
    Character.find_each do |character|
      character.image.purge if character.image.attached?
    end
  end
end
