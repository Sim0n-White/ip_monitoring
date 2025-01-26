# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "dry/monads"

module IpMonitoring
  class Action < Hanami::Action
    # Provide `Success` and `Failure` for pattern matching on operation results
    include Dry::Monads[:result]

    config.handle_exception ROM::TupleCountMismatchError => :handle_not_found

    private

    def handle_not_found(_request, response, _exception)
      response.status = 404
      response.format = :json
      response.body = { error: "not_found" }.to_json
    end

    def check_params(request)
      halt 422, { errors: request.params.errors }.to_json unless request.params.valid?
    end

    def find_ip_by_id(id)
      ip_repo.get!(id)
    end
  end
end
