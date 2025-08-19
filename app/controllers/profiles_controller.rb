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

  # メールアドレス編集
  def edit_email
    @user = current_user
  end

  def update_email
    @user = current_user

    if @user.update(profile_params)
      redirect_to profile_path, notice: "確認メールを送信しました。メール内のリンクをクリックして変更を完了してください。"
    else
      flash.now[:alert] = "メールアドレスを更新できませんでした。"
      render :edit_email, status: :unprocessable_entity
    end
  end

  # アバター編集
  def edit_avatar
    @user = current_user

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("avatar-edit-form", partial: "profiles/edit_avatar", locals: { user: @user }
      )
      end
    end
  end

  def update_avatar
    @user = current_user

    if @user.update(profile_params)
      flash.now[:notice] = "プロフィール画像を更新しました。"

      respond_to do |format|
        format.html { redirect_to profile_path }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { render :edit_avatar, status: :unprocessable_entity }
        format.turbo_stream { render :edit_avatar, status: :unprocessable_entity }
      end
    end
  end

  def remove_avatar
    @user = current_user

    @user.avatar.purge
    redirect_to profile_path, notice: "画像を削除しました"
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
