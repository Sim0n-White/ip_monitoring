# frozen_string_literal: true

module IpMonitoring
  module Repos
    class IpRepo < IpMonitoring::DB::Repo
      def create(attributes)
        ips.changeset(:create, attributes).commit
      end

      def find_by_ip(ip)
        ips.where(ip: ip).one
      end
    end
  end
end
