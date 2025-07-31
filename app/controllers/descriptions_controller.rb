class DescriptionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :how_character_selection ]
  # キャラクター変更機能の説明
  def how_character_selection
    respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.append(
              "character-selection",
              partial: "shared/character_selection"
            )
      end
    end
  end
end
