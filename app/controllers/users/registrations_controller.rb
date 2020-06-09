class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
		ThanksMailer.thanks_mail(@user).deliver_now
  end
end