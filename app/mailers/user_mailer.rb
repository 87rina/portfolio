class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    if record.confirmed?
    # メールアドレス変更用テンプレートを使う
    opts[:template_name] = 'confirmation_instructions_for_change'
    else
    # 新規登録用テンプレートを使う
    opts[:template_name] = 'confirmation_instructions_for_signup'
    end
    super
  end
end