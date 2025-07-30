class DescriptionsController < ApplicationController
  # キャラクター変更機能の説明
  def how_character_selection
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("body", partial: "shared/character_selection")
      end
    end
  end
end
