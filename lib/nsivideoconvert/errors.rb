module NSIVideoConvert
  module Errors
    module Client
      class KeyNotFoundError < RuntimeError
      end

      class MissingParametersError < RuntimeError
      end

      class MalformedRequestError < RuntimeError
      end

      class AuthenticationError < RuntimeError
      end

      class SAMConnectionError < RuntimeError
      end

      class ConnectionRefusedError < RuntimeError
      end

      class QueueServiceConnectionError < RuntimeError
      end
    end
  end
end
