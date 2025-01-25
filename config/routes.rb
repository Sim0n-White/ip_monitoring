# frozen_string_literal: true

module IpMonitoring
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    post "/ips", to: "ips.create"
  end
end
