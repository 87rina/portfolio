class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line; basic_action end

  private
  def basic_action
    @omniauth = request.env["omniauth.auth"]  # OmniAuth が返してきた認証情報を取得
    if @omniauth.present?
      # すでにこのSNSでログインしたことがあるか探す
      @profile = User.find_by(provider: @omniauth["provider"], uid: @omniauth["uid"])

      # 初めてのSNSログインの場合はOmniAuthからemailを取得
      # できない場合はダミーアドレス（uid-provider@example.com）を作成
      unless @profile
        email = @omniauth["info"]["email"].presence || fake_email(@omniauth["uid"], @omniauth["provider"])

        # 既存ユーザーにLINEアカウントを紐付け
        if current_user
          current_user.update!(provider: @omniauth["provider"], uid: @omniauth["uid"])
          @profile = current_user

        # 完全な新規ユーザーの場合、新しくUserを作成
        else
        @profile = User.create!(
                    provider: @omniauth["provider"],
                    uid: @omniauth["uid"],
                    email: email,
                    name: @omniauth["info"]["name"],
                    password: Devise.friendly_token[0, 20]
                  )
        end
      end
      @profile.set_values(@omniauth) # set_values メソッドを呼び出し、トークンや追加情報を保存
      sign_in(:user, @profile) # Deviseの機能で、ログイン処理を実行
      flash[:notice] = "ログインしました"
    end
    
    redirect_to root_path
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
