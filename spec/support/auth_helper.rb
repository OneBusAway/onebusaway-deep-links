# frozen_string_literal: true

def sign_in(user, options = {})
  password = options[:password] || 'password'
  post login_path, params: { session: { email: user.email, password: } }
end

def sign_out
  get logout_path
end
