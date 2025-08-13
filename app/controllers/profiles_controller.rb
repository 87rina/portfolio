class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # 名前、アバター管理 
  def show
    @user = current_user
  end

  def edit
    @user = current_user
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      respond_to do |format|
        format.html { redirect_to profile_path, notice: "プロフィールを更新しました。" }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :avatar)
  end
end
