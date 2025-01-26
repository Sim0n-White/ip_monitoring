# frozen_string_literal: true

module IpMonitoring
  module Actions
    module Ips
      class Enable < IpMonitoring::Action
        include Deps["repos.ip_repo"]

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          check_params(request)

          updated_ip = ip_repo.update(find_ip_by_id(request.params[:id]).id, enabled: true, updated_at: Time.now)

          response.format = :json
          response.body = updated_ip.to_h.to_json
        end
      end
    end
  end
end
