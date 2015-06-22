class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    if user.try(:role)
      send(user.role)
    else
      guest
    end
  end

private
    def guest
      can [:show, :index], Team
    end

    def user
      guest
      can :manage, Game do |game|
        game.user_id == @user.id
      end
      can [:edit_score, :update_score, :update, :create_note, :destroy_note], Game do |game|
        game.supported_by @user
      end
      can [:create], Team
      can [:create_comment], Game
    end

    def admin
      user
      can :manage, Game
      can :manage, Team
      can :manage, User
    end
end
