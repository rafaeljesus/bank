require 'jwt'

module Bank
  module Support
    class Token
      def self.encode(user)
        payload = {id: user.id.to_s}
        JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
      end

      def self.decode(bearer)
        options = {algorithm: 'HS256'}
        JWT.decode(bearer, ENV['JWT_SECRET'], true, options)
      end
    end
  end
end
