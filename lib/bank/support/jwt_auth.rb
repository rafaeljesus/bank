require 'bank/support/token'

module Bank
  module Support
    class JwtAuth
      def initialize(app)
        @app = app
      end

      def call(env)
        return @app.call(env) if env['PATH_INFO'] == '/v1/users' ||
          env['PATH_INFO'] == '/v1/token'

        begin
          bearer = env.fetch('HTTP_AUTHORIZATION', '').slice(7..-1)
          payload = Token.decode(bearer)
          env[:user] = payload.first

          @app.call(env)
        rescue JWT::DecodeError
          [401, {'Content-Type' => 'text/plain'}, ['A token must be passed.']]
        end
      end
    end
  end
end
