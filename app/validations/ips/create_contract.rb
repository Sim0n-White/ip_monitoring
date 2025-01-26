# frozen_string_literal: true

require "dry/validation"

module IpMonitoring
  module Validations
    module Ips
      class CreateContract < Dry::Validation::Contract
        params do
          required(:ip).hash do
            required(:ip).filled(:string)
            optional(:enabled).filled(:bool)
          end
        end

        rule(ip: :ip) do
          begin
            IPAddr.new(value)
            repo = IpMonitoring::Repos::IpRepo.new
            key.failure("already exists") if repo.find_by_ip(value)
          rescue IPAddr::InvalidAddressError
            key.failure("must be a valid IPv4 or IPv6 address")
          end
        end
      end
    end
  end
end
