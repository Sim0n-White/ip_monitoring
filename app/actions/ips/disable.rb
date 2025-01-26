# frozen_string_literal: true

module IpMonitoring
  module Actions
    module Ips
      class Disable < IpMonitoring::Action
        include Deps["repos.ip_repo"]

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          ip = ip_repo.get!(request.params[:id])
          updated_ip = ip_repo.update(ip.id, enabled: false, updated_at: Time.now)

          response.format = :json
          response.body = updated_ip.to_h.to_json
        end
      end
    end
  end
end
