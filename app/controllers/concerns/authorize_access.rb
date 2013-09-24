module AuthorizeAccess
  extend ActiveSupport::Concern

  included do
    extend ClassMethods
  end

  module ClassMethods
    def perform_authorization_for(*action_names)
      include InstanceMethods
      before_filter :perform_authorization, only: action_names.blank? ? [] : action_names
    end
  end

  module InstanceMethods
    private
    def perform_authorization
      do_force_login && return unless logged_in?
      valid_screen_name?
    end

    def do_force_login
      redirect_to login_path
    end

    def valid_screen_name?
      current_user.screen_name == params[:screen_name]
    end
  end
end
