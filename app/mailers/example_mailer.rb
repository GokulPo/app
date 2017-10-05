class ExampleMailer < ApplicationMailer
   default from: "from@example.com"
  def sample_email(user,pwd)
    @user = user
    @password =pwd

    mail(to: @user.email, subject: 'Sample Email')
  end

end
