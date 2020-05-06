class RegistrationMailer < ApplicationMailer
  default from: 'rahul@poplify.com'
  layout 'mailer'

def welcome_user(user,password)
    @user = user
    @password = password
    #@token = token
   # cuponcode = DealVoucher.find_by(id: 15).try(:voucher_code)
   # link_to_loginpage = hsh[:link_to_loginpage]
    #template_name = 'fz-welcome-email'
     mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
    #vars = { 'username' => username, 'cuponcode' => cuponcode, 'link_to_loginpage' => link_to_loginpage, 'website_link' => welcomelink, 'copyright_year' => Time.now.strftime('%Y') }
    #args = { email: email, template_name: template_name, vars: vars }
    #mandril_sendmail(args)
  end

  def invite_employe(user)

    @user = user

   mail( :to => @user.email,
    :subject => 'Invitation link' )

  end  

end
