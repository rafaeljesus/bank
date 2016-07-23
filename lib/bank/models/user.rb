module Bank
  module Models
    class User
      include Mongoid::Document
      include Mongoid::Timestamps

      field :email, type: String
      field :password, type: String

      validates_presence_of :email, :password
    end
  end
end
