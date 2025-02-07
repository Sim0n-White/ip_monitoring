# frozen_string_literal: true

RSpec.describe "DELETE /ips/:id", type: [:request, :db] do
  let(:repo) { IpMonitoring::Repos::IpRepo.new }

  describe "valid requests" do
    context "when the IP exists" do
      let!(:ip) { repo.create(ip: Faker::Internet.ip_v4_address, enabled: true, created_at: Time.now, updated_at: Time.now) }
      let(:id) { ip[:id] }

      it "deletes the IP and returns success message" do
        delete "/ips/#{id}", {}

        expect(last_response.status).to eq(200)
        response_body = JSON.parse(last_response.body)
        expect(response_body["message"]).to eq("IP address deleted successfully")

        expect { repo.get!(id) }.to raise_error(ROM::TupleCountMismatchError)
      end
    end
  end

  describe "invalid requests" do
    context "when the ID is invalid" do
      let(:id) { "invalid_id" }

      it "returns 422 unprocessable entity with error details" do
        delete "/ips/#{id}", {}

        expect(last_response.status).to eq(422)
        response_body = JSON.parse(last_response.body)
        expect(response_body["errors"]).to be
      end
    end

    context "when the IP id is not found" do
      let(:id) { 9999 }

      it "returns 404 not found" do
        delete "/ips/#{id}", {}

        expect(last_response.status).to eq(404)
        response_body = JSON.parse(last_response.body)
        expect(response_body["error"]).to eq("not_found")
      end
    end
  end
end
