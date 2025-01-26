# frozen_string_literal: true

module IpMonitoring
  module Actions
    module Ips
      class Stats < IpMonitoring::Action
        include Deps["repos.ip_repo", "repos.ip_check_repo"]

        params do
          required(:id).value(:integer)
          required(:time_from).value(:time)
          required(:time_to).value(:time)
        end

        def handle(request, response)
          check_params(request)

          stats = collect_stats(request, ip_repo.get!(request.params[:id]))
          empty_stats if stats.nil?

          response.format = :json
          response.body = stats.to_json
        end

        private

        def collect_stats(request, ip)
          ip_check_repo.statistics(ip.id, request.params[:time_from], request.params[:time_to])
        end

        def empty_stats
          halt 404, { error: "No data available for the given period" }.to_json
        end
      end
    end
  end
end
