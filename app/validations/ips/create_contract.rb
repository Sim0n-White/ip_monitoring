# frozen_string_literal: true

require "dry/validation"

module IpMonitoring
  module Validations
    module Ips
      class CreateContract < Dry::Validation::Contract
        params do
          required(:ip).hash do
            required(:ip).filled(:string, format?: /\A
                                                    (# Начало блока для IPv4
                                                      (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.
                                                      (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.
                                                      (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.
                                                      (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])
                                                    )
                                                    |
                                                    (# Начало блока для IPv6
                                                      (?:[a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4}
                                                    )
                                                    \z/x)
            optional(:enabled).filled(:bool)
          end
        end

        rule(:ip) do
          repo = IpMonitoring::Repos::IpRepo.new
          key.failure("already exists") if repo.find_by_ip(value[:ip])
        end
      end
    end
  end
end
