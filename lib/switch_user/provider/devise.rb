module SwitchUser
  module Provider
    class Devise < Base
      def initialize(controller)
        @controller = controller
        @warden = @controller.warden
      end

      def login(user, scope = :user)
        if SwitchUser.update_devise_last_signin_ip
          @warden.session_serializer.store(user, scope) 
        else
          @warden.set_user(user, :scope => scope)
        end
      end

      def logout(scope = :user)
        @warden.logout(scope)
      end

      def current_user(scope = :user)
        @warden.user(scope)
      end
    end
  end
end
