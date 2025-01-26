# frozen_string_literal: true

module IpMonitoring
  module Actions
    module Ips
      class Create < IpMonitoring::Action
        include Deps["repos.ip_repo"]

        def handle(request, response)
          validate_params(request)

          ip = ip_repo.create(request.params[:ip])

          response.status = 201
          response.format = :json
          response.body = ip.to_h.to_json
        end

        private

        def validate_params(request)
          contract = IpMonitoring::Validations::Ips::CreateContract.new
          validation = contract.call(request.params.to_h)
          halt 422, { errors: validation.errors.to_h }.to_json unless validation.success?
        end
      end
    end
  end
end
