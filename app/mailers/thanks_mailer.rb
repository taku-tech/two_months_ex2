class ThanksMailer < ApplicationMailer
	default from: 'no-replay@gmail.com'

  def thanks_mail(user)
    @user = user
    @url = "localhost:3000/users/#{@user.id}"
    mail(subject: "Bookersへの登録ありがとう！！" ,to: @user.email)
  end
end
