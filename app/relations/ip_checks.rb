# frozen_string_literal: true

module IpMonitoring
  module Relations
    class IpChecks < IpMonitoring::DB::Relation
      schema :ip_checks, infer: true
    end
  end
end
