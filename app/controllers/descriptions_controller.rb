class DescriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :how_character_selection, :how_to_write, :how_to_use ]
  # 「キャラクター変更」
  def how_character_selection
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("character-selection", partial: "shared/character_selection")
      end
    end
  end

  # 「書き方に困ったら」
  def how_to_write
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("how-to-write", partial: "shared/how_to_write")
      end
    end
  end

  # 『アプリの使い方」
  def how_to_use
  end
end
