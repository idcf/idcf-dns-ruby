# frozen_string_literal: true

describe Idcf::Dns::ClientExtensions::Zone do
  include_context "resources"

  context "ゾーン" do
    example "ゾーンを作成できるか" do
      response = client.create_zone(zone_params)
      expect(response.status).to eq 201
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
      expect(response.uuid).to be_truthy
    end

    example "ゾーン一覧を取得できるか" do
      response = client.list_zones
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
    end

    example "ゾーン一覧のオブジェクトを取得できるか" do
      response = client.zones
      expect(response).to be_truthy
      expect(response.count).to be_truthy
    end

    example "ゾーンを取得できるか" do
      response = client.get_zone(zone_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
      expect(response.uuid).to be_truthy
    end

    example "ゾーンのオブジェクトを取得できるか" do
      response = client.zone(zone_uuid)
      expect(response).to be_truthy
    end

    example "ゾーンの認証情報を取得できるか" do
      response = client.get_token(zone_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを認証できるか" do
      response = client.verify_zone(zone_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを変更できるか" do
      params = {
        default_ttl: 3600,
        description: "update",
      }
      response = client.update_zone(zone_uuid, params)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを削除できるか" do
      response = client.delete_zone(zone_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
    end
  end

  context "ゾーン（パス指定）" do
    example "ゾーンを作成できるか" do
      headers = { add: "header" }
      response = client.post("zones", zone_params, headers)
      expect(response.status).to eq 201
      expect(response.body).to be_truthy
    end

    example "ゾーン一覧を取得できるか" do
      response = client.get("zones")
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを取得できるか" do
      response = client.get("zones/#{zone_uuid}")
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンの認証情報を取得できるか" do
      response = client.get("zones/#{zone_uuid}/token")
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを認証できるか" do
      response = client.post("zones/#{zone_uuid}/verify")
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを変更できるか" do
      params = {
        default_ttl: 3600,
        description: "update",
      }
      response = client.put("zones/#{zone_uuid}", params)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "ゾーンを削除できるか" do
      response = client.delete_zone(zone_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end
  end
end
