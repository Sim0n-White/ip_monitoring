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
          check_params(request)

          ip_repo.delete(find_ip_by_id(request.params[:id]).id)

          response.format = :json
          response.body = { message: "IP address deleted successfully" }.to_json
        end
      end
    end
  end
end
