# frozen_string_literal: true

RSpec.describe "POST /ips/:id/enable", type: [:request, :db] do
  let(:repo) { IpMonitoring::Repos::IpRepo.new }

  describe "valid requests" do
    context "when the request is valid" do
      let!(:ip) { repo.create(ip: Faker::Internet.ip_v4_address, enabled: false, created_at: Time.now, updated_at: Time.now).to_h }
      let(:id) { ip[:id] }

      it "enables the IP and returns it as JSON" do
        post "/ips/#{id}/enable", {}

        expect(last_response.status).to eq(200)
        response_body = JSON.parse(last_response.body)
        expect(response_body["id"]).to eq(ip[:id])
        expect(response_body["ip"]).to eq(ip[:ip].to_s)
        expect(response_body["enabled"]).to eq(true)
      end
    end
  end

  describe "invalid requests" do
    context "when the request has invalid parameters" do
      let(:id) { "invalid_id" }

      it "returns 422 unprocessable entity with error details" do
        post "/ips/#{id}/enable", {}

        expect(last_response.status).to eq(422)
        response_body = JSON.parse(last_response.body)
        expect(response_body["errors"]).to be
      end
    end

    context "when the IP id is not found" do
      let(:id) { 9999 }

      it "returns 404 not found" do
        post "/ips/#{id}/enable", {}

        expect(last_response.status).to eq(404)
        response_body = JSON.parse(last_response.body)
        expect(response_body["error"]).to eq("not_found")
      end
    end
  end
end
