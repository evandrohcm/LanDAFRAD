class ClienteMailer < ActionMailer::Base
  default from: "evandro.macedo@servicenet.com.br"

  def welcome_message
    mail(
      :subject => 'E-mail enviado usando o Postmark',
      :to      => 'evandro.hcm@gmail.com',
      :tag     => 'Tag Postmark'
    )
  end
end
