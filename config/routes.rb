# frozen_string_literal: true

module IpMonitoring
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    post "/ips", to: "ips.create"
    post "/ips/:id/enable", to: "ips.enable"
    post "/ips/:id/disable", to: "ips.disable"
    get "/ips/:id/stats", to: "ips.stats"
    delete "/ips/:id", to: "ips.delete"
  end
end
