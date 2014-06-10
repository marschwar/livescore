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
    end

    def user
      guest
      can :manage, Game do |game|
        game.user_id == @user.id
      end
      can [:edit_score, :update_score, :update, :create_note, :destroy_note], Game do |game|
        game.supported_by @user
      end
      can [:create, :update], Team
    end

    def admin
      user
      can :manage, Game
      can :manage, Team
      can :manage, User
    end
end
