# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # All users
    can :index, Article
    can :show, Article, public: true
    can :search, Article

    if user.present?
      can :show, Article, public: false

      can :new, Article
      can :create, Article

      can :edit, Article, user_id: user.id
      can :update, Article, user_id: user.id

      can :destroy, Article, user_id: user.id
    end
  end
end
