# frozen_string_literal: true

require "bundler/setup"
require "idcf/dns"
require "dotenv"

require "simplecov"
SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

dotenv_path = File.expand_path("../../.env", __FILE__)
if File.exist?(dotenv_path)
  require "dotenv"
  Dotenv.load(dotenv_path)
end

auth_args = {
  api_key: ENV["IDCF_API_KEY"],
  secret_key: ENV["IDCF_SECRET_KEY"],
  host: ENV["DNS_API_HOST"] || "dns.idcfcloud.com",
  verify_ssl: ENV["VERIFY_SSL"] != "false",
}

zone_name = ENV["DNS_ZONE_NAME"] || "example.com"

zone_params = {
  name: zone_name,
  email: "postmaster@example.com",
  default_ttl: 3600,
  description: "create",
}

a_record_params = {
  type: "A",
  name: "a.#{zone_name}",
  content: "192.0.2.1",
  ttl: 3600,
}

shared_context "resources" do
  let(:client) { Idcf::Dns::Client.new(auth_args) }
  let(:zone_name) { zone_name }
  let(:zone_uuid) { get_zone_uuid }
  let(:zone_params) { zone_params }
  let(:a_record_params) { a_record_params }
end

def get_zone_uuid
  client.list_zones.body.each do |zone|
    next unless zone["name"] == zone_name
    return zone["uuid"]
  end
  raise(ArgumentError, "Not Found (zone: #{zone_name}).")
end

def get_record_uuid(type, gslb = false)
  record_name = gslb ? "-gslb" : ""
  record_name = "#{type.downcase}#{record_name}.#{zone_name}"
  client.list_records(zone_uuid).body.each do |record|
    next unless record["name"] == record_name && record["type"] == type
    return record["uuid"]
  end
  raise(ArgumentError, "Not Found (record: #{record_name}).")
end
