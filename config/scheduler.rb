require "rufus-scheduler"
require "./lib/ip_monitoring/services/ip_checker"

scheduler = Rufus::Scheduler.new

scheduler.every "1m" do
  ip_repo = IpMonitoring::Repos::IpRepo.new
  ip_check_repo = IpMonitoring::Repos::IpCheckRepo.new
  IpMonitoring::Services::IpChecker.new(ip_repo, ip_check_repo).run
end

scheduler.join
