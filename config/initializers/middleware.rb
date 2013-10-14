require "json"
require "ipaddr"
require "set"

module BetterErrors
  class Middleware
    private

    def allow_ip?(env)
      if !Rails.env.production?
        return true
      end
      # REMOTE_ADDR is not in the rack spec, so some application servers do
      # not provide it.
      return true unless env["REMOTE_ADDR"] and !env["REMOTE_ADDR"].strip.empty?
      ip = IPAddr.new env["REMOTE_ADDR"].split("%").first
      ALLOWED_IPS.any? { |subnet| subnet.include? ip }
    end
  end
end