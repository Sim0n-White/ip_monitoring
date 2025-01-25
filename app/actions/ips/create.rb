# frozen_string_literal: true

module IpMonitoring
  module Actions
    module Ips
      class Create < IpMonitoring::Action
        include Deps["repos.ip_repo"]

        def handle(request, response)
          contract = IpMonitoring::Validations::Ips::CreateContract.new
          validation = contract.call(request.params.to_h)

          if validation.success?
            ip = ip_repo.create(request.params[:ip])
            puts ip
            response.status = 201
            response.body = { id: ip.id, ip: ip.ip, enabled: ip.enabled }.to_json
          else
            response.status = 422
            response.body = { errors: validation.errors.to_h }.to_json
          end
        end
      end
    end
  end
end
