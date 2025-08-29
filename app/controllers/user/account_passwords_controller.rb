class User::AccountPasswordsController < ApplicationController
  # ログイン時のパスワード変更
  before_action :authenticate_user!

  def edit
  end

  def update
    if current_user.update_with_password(user_params)
      bypass_sign_in(current_user) # セッションを維持
      redirect_to profile_path, notice: "パスワードが更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
