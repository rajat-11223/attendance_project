class MailWorker 
  include Sidekiq::Worker

  def perform(user_id, pwd, role)
    # do something
    @user = User.find(user_id)
    RegistrationMailer.with(user: @user,password: pwd,role: role).welcome_user.deliver_now
  end
end