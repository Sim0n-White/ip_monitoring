RSpec.describe "POST /ips", type: [:request, :db] do
  let(:request_headers) do
    { "HTTP_ACCEPT" => "application/json", "CONTENT_TYPE" => "application/json" }
  end

  context "when given a valid IPv4 address" do
    let(:params) do
      { ip: { ip: "8.8.8.8", enabled: true } }
    end

    it "creates an IP" do
      post "/ips", params.to_json, request_headers

      response = JSON.parse(last_response.body)
      expect(last_response.status).to eq(201)
      expect(response["ip"]).to eq("8.8.8.8")
      expect(response["enabled"]).to eq(true)
    end
  end

  context "when given a valid IPv6 address" do
    let(:params) do
      { ip: { ip: "2001:fdb8:85a3:85a3:85a3:8a2e:1370:7334", enabled: true } }
    end

    it "creates an IP" do
      post "/ips", params.to_json, request_headers

      response = JSON.parse(last_response.body)
      expect(last_response.status).to eq(201)
      expect(response["ip"]).to eq("2001:fdb8:85a3:85a3:85a3:8a2e:1370:7334")
      expect(response["enabled"]).to eq(true)
    end
  end

  context "when given an invalid IP address" do
    let(:params) do
      { ip: { ip: "invalid_ip", enabled: true } }
    end

    it "returns 422 unprocessable entity" do
      post "/ips", params.to_json, request_headers

      expect(last_response.status).to eq(422)
      expect(last_response.body).to include("errors")
    end
  end

  context "when given an empty IP address" do
    let(:params) do
      { ip: { ip: "", enabled: true } }
    end

    it "returns 422 unprocessable entity" do
      post "/ips", params.to_json, request_headers

      expect(last_response.status).to eq(422)
      expect(last_response.body).to include("errors")
    end
  end
end
