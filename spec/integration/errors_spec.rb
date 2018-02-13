# frozen_string_literal: true

describe Idcf::Dns::Error do
  context "異常系テスト" do
    example "認証情報が不正な場合エラーが帰るか" do
      client = Idcf::Dns::Client.new(
        api_key: ("A" * 86),
        secret_key: ("A" * 86),
        host: "dns.idcfcloud.com",
        verify_ssl: true
      )
      expect { client.list_zones }.to raise_error(
        Idcf::Dns::ApiError
      )
    end
  end
end
