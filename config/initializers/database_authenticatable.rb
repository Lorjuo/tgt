require 'devise/strategies/database_authenticatable'
require 'bcrypt'

# module Devise
#   module Models
#     module DatabaseAuthenticatable
#       # Verifies whether an password (ie from sign in) is the user password.
#       def valid_password?(password)
#         #TODO: enable / disable authentication depending on config
#         #return true
#         return false if encrypted_password.blank?
#         bcrypt   = ::BCrypt::Password.new(encrypted_password)
#         password = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt.salt)
#         Devise.secure_compare(password, encrypted_password)
#       end
#     end
#   end
# end