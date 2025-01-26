# frozen_string_literal: true

require "net/ping"

module IpMonitoring
  module Services
    class IpChecker
      def initialize(ip_repo, ip_check_repo)
        @ip_repo = ip_repo
        @ip_check_repo = ip_check_repo
      end

      def run
        # Отмечу, что можно вынести в threads или в backgroud job'ы. Для прототипа решил оставить как есть
        @ip_repo.enabled_ips.each do |ip|
          create_ip_check(ip)
        end
      end

      private

      def create_ip_check(ip)
        checker = Net::Ping::External.new(ip.ip.to_s)
        checker.timeout = 1 # Выставляем таймаут в 1 секунду
        rtt = checker.duration if checker.ping?

        @ip_check_repo.create(
          ip_id: ip.id,
          rtt: rtt,
          checked_at: Time.now
        )
      end
    end
  end
end
