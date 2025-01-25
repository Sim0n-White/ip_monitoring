# frozen_string_literal: true

module IpMonitoring
  module Relations
    class Ips < IpMonitoring::DB::Relation
      schema :ips, infer: true
    end
  end
end
