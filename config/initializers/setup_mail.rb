ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "ryan.armbrust@gmail.com",
  :password             => "93android",
  :authentication       => "plain",
  :enable_starttls_auto => true
}


ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?