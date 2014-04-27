module CurrentUser
  extend ActiveSupport::Concern

  included do
    before_filter :check_for_user
  end

  def current_user
    @current_user
  end

private
  def check_for_user
    id = session_user_id
    id = remember_me unless id
    begin
      @current_user = User.find(id) if id
    rescue
      logger.info "User_ID #{id} from session or cookie invalid"
    end
  end

  def remember_me
    logger.info "remember_me cookie is #{cookies.signed[:remember_me]}"
    cookies.signed[:remember_me]
  end

  def remember_me=(value)
    logger.info "Setting remember_me cookie to #{value}"
    cookies.permanent.signed[:remember_me] = value
  end

  def session_user_id
    session[:user_id]
  end

  def session_user_id=(value)
    logger.info "Setting session_user_id to #{value}"
    session[:user_id] = value
  end
end