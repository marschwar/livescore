class AuthService

  def handle_auth_success(auth_hash)
    # see https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    user = User.find_or_create_by social_id: auth_hash[:uid]
    info = auth_hash[:info]
    user.common_name = info[:name]
    user.email = info[:email]
    user.remote_avatar_url = info[:image].sub('http:','https:') if info[:image].present?
    user.active = true

    user.save!

    user
  end

end