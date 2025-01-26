# frozen_string_literal: true

RSpec.describe "POST /ips", type: [:request, :db] do
  let(:repo) { IpMonitoring::Repos::IpRepo.new }

  describe "valid requests" do
    context "when given a valid IPv4 address" do
      let(:params) do
        { ip: { ip: Faker::Internet.ip_v4_address, enabled: true } }
      end

      it "creates an IP" do
        post "/ips", params

        response = JSON.parse(last_response.body)
        expect(last_response.status).to eq(201)
        expect(response["ip"]).to eq(params[:ip][:ip])
        expect(response["enabled"]).to eq(params[:ip][:enabled])
      end
    end

    context "when given a valid IPv6 address" do
      let(:params) do
        { ip: { ip: Faker::Internet.ip_v6_address, enabled: true } }
      end

      it "creates an IP" do
        post "/ips", params

        response = JSON.parse(last_response.body)
        expect(last_response.status).to eq(201)
        expect(response["ip"]).to eq(params[:ip][:ip])
        expect(response["enabled"]).to eq(params[:ip][:enabled])
      end
    end
  end

  describe "invalid requests" do
    context "when given an invalid IP address" do
      let(:params) do
        { ip: { ip: "invalid_ip", enabled: true } }
      end

      it "returns 422 unprocessable entity" do
        post "/ips", params

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include("errors")
      end
    end

    context "when given an empty IP address" do
      let(:params) do
        { ip: { ip: "", enabled: true } }
      end

      it "returns 422 unprocessable entity" do
        post "/ips", params

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include("errors")
      end
    end

    context "when given a duplicate IP address" do
      let(:duplicate_ip) { Faker::Internet.ip_v4_address }
      let(:params) do
        {
          ip: {
            ip: duplicate_ip,
            enabled: true
          }
        }
      end

      before do
        repo.create(params[:ip])
      end

      it "returns 422 unprocessable entity" do
        post "/ips", params

        expect(last_response.status).to eq(422)
        expect(last_response.body).to include("already exists")
      end
    end
  end
end
