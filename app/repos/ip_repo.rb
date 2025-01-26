# frozen_string_literal: true

module IpMonitoring
  module Repos
    class IpRepo < IpMonitoring::DB::Repo
      commands :create, update: :by_pk, delete: :by_pk

      def get!(id)
        ips.by_pk(id).one!
      end

      def find_by_ip(ip)
        ips.where(ip: ip).one
      end

      def enabled_ips
        ips.where(enabled: true).to_a
      end
    end
  end
end
