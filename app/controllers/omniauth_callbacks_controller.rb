class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line; basic_action end

  private
  def basic_action
    @omniauth = request.env["omniauth.auth"]  # OmniAuth が返してきた認証情報を取得
    if @omniauth.present?
      # SNSアカウントと対応するユーザーを探す
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        # メールアドレスが設定されていない場合の処理
        # OmniAuthから email が取得できない場合はダミーアドレス（uid-provider@example.com）を作成
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        # すでにcurrent_userがある場合はそのユーザーにSNS情報を紐づける。ない場合は新しくUserを作成
        @profile = current_user || User.create!(
                    provider: @omniauth["provider"],
                    uid: @omniauth["uid"],
                    email: email,
                    name: @omniauth["info"]["name"],
                    password: Devise.friendly_token[0, 20]
                  )
      end
      @profile.set_values(@omniauth) # set_values メソッドを呼び出し、トークンや追加情報を保存
      sign_in(:user, @profile) # Deviseの機能で、ログイン処理を実行
    end
    flash[:notice] = "ログインしました"
    redirect_to root_path
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
