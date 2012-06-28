module NSIVideoConvert
  class Client
    class Configuration
      class << self
        # Set the default {NSIVideoConvert::Client} user
        #
        #
        # @param [String] user to set
        #
        # @return [String] the user set
        def user(user = nil)
          @user = user unless user.nil?
          @user
        end

        # Set the default {NSIVideoConvert::Client} password
        #
        #
        # @param [String] password to set
        #
        # @return [String] the password set
        def password(password = nil)
          @password = password unless password.nil?
          @password
        end

        # Set the default {NSIVideoConvert::Client} host
        #
        #
        # @param [String] host to set
        #
        # @return [String] the host set
        def host(host = nil)
          @host = host unless host.nil?
          @host
        end

        # Set the default {NSIVideoConvert::Client} port
        #
        #
        # @param [String] port to set
        #
        # @return [String] the port set
        def port(port = nil)
          @port = port unless port.nil?
          @port
        end

        # See how are the settings
        #
        # @return [Hash] actual settings
        def settings
          {user: @user, password: @password, host: @host, port: @port}
        end
      end
    end
  end
end
