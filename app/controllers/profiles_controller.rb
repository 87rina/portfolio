class ProfilesController < ApplicationController
  # 名前、アバター管理
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  # 名前編集
  def edit_name
    @user = current_user

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("name-edit-form", partial: "profiles/edit_name", locals: { user: @user }
      )
      end
    end
  end

  def update_name
    @user = current_user

    if @user.update(profile_params)
      flash.now[:notice] = "名前を更新しました。"

      respond_to do |format|
        format.html { redirect_to profile_path }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit_name, status: :unprocessable_entity }
        format.turbo_stream { render :edit_name, status: :unprocessable_entity }
      end
    end
  end

  # アバター編集
  def edit_avatar
  end

  def update_avatar
  end

  private

  def profile_params
    params.require(:user).permit(:name, :avatar)
  end
end
