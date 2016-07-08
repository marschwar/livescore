class SessionsController < ApplicationController

  def create

    logger.info "Auth-Hash: #{auth_hash}"
    user = auth_service.handle_auth_success auth_hash
    logger.info "User: #{user.try(:inspect)}"
    self.session_user_id = user.id
    self.remember_me = user.id

    check_for_changed_social_id user

    redirect_to root_path
  end

  def clear
    session.clear
    self.remember_me = nil
    redirect_to '/'
  end

private

  def auth_service
    @auth_service ||= AuthService.new
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  # If we change the facebook application, new social ids seem to be assigned
  def check_for_changed_social_id(user)
    User.where(active: false, common_name: user.common_name).each do |old_user|
      Game.where(user: old_user).update_all(user_id: user)
      Supporter.where(user: old_user).update_all(user_id: user)
    end
  end
end
