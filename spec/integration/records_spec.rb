# frozen_string_literal: true

describe Idcf::Dns::ClientExtensions::Record do
  include_context "resources"

  context "レコード系のテスト" do
    example "ゾーン作成" do
      begin
        client.create_zone(zone_params)
      rescue => e
        # ゾーン系のテストはzone_specで実施する
        p e
      end
    end

    example "レコードを作成できるか" do
      response = client.create_record(zone_uuid, a_record_params)
      expect(response.status).to eq 201
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
      expect(response.uuid).to be_truthy
    end

    example "レコード一覧を取得できるか" do
      response = client.list_records(zone_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
    end

    example "レコード一覧のオブジェクトを取得できるか" do
      response = client.records(zone_uuid)
      expect(response).to be_truthy
      expect(response.count).to be_truthy
    end

    example "レコードを取得できるか" do
      record_uuid = get_record_uuid("A")
      response = client.get_record(zone_uuid, record_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
      expect(response.uuid).to be_truthy
    end

    example "レコードのオブジェクトを取得できるか" do
      record_uuid = get_record_uuid("A")
      response = client.record(zone_uuid, record_uuid)
      expect(response).to be_truthy
    end

    example "レコードを変更できるか" do
      params = {
        type: "A",
        name: "a.#{zone_name}",
        content: "192.0.2.2",
        ttl: 3600,
      }
      record_uuid = get_record_uuid("A")
      response = client.update_record(zone_uuid, record_uuid, params)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
    end

    example "レコードを削除できるか" do
      record_uuid = get_record_uuid("A")
      response = client.delete_record(zone_uuid, record_uuid)
      expect(response.status).to eq 200
      expect(response.body).to be_truthy
      expect(response.count).to be_truthy
    end

    example "不正な値を入れてレコードを作成できるか" do
      params = {
        type: "AA",
        name: "a.#{zone_name}",
        content: "192.0.2.2",
        ttl: 3600,
      }
      expect { client.create_record(zone_uuid, params) }.to raise_error(
        Idcf::Dns::InvalidAttributeType
      )
      params = {}
      expect { client.create_record(zone_uuid, params) }.to raise_error(
        Idcf::Dns::MissingAttribute
      )
    end

    example "ゾーン削除" do
      client.delete_zone(zone_uuid)
    end
  end
end
