# frozen_string_literal: true

module IpMonitoring
  module Actions
    module Ips
      class Delete < IpMonitoring::Action
        include Deps["repos.ip_repo"]

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          ip = ip_repo.get!(request.params[:id])
          ip_repo.delete(ip.id)

          response.status = 200
          response.format = :json
          response.body = { message: "IP address deleted successfully" }.to_json
        end
      end
    end
  end
end
