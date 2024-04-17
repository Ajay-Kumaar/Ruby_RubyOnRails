class User < ApplicationRecord
    def self.generate_random_email
      SecureRandom.hex(4) + "@gmail.com"
    end
end