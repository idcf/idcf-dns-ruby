require "simplecov"
SimpleCov.start do
  add_filter "vendor"
  add_filter "spec"
end

SimpleCov.minimum_coverage 90

if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

dotenv_path = File.expand_path("../../.env", __FILE__)
if File.exist?(dotenv_path)
  require "dotenv"
  Dotenv.load(dotenv_path)
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "idcf/dns"

PREFIX = rand(16**8).to_s(16)
ZONES = [].freeze

auth_args = {
  api_key: ENV["IDCF_API_KEY"],
  secret_key: ENV["IDCF_SECRET_KEY"],
  host: ENV["DNS_API_HOST"] || "dns.idcfcloud.com",
  verify_ssl: ENV["VERIFY_SSL"] != "false",
}

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.after(:suite) do
    client = Idcf::Dns::Client.new(auth_args)
    ZONES.reverse_each do |zone_uuid|
      client.delete_zone(zone_uuid)
    end
  end
end

shared_context "resources" do
  let(:client) { Idcf::Dns::Client.new(auth_args) }

  def zone_attributes(attributes = {})
    {
      name: "rspec-#{PREFIX}-#{ZONES.size}.idcf-dns-ruby.jp",
      email: "rspec@idcf-dns-ruby.jp",
      description: "For idcf-dns-ruby rspec",
      default_ttl: 600,
    }.merge(attributes)
  end

  def record_attributes(attributes = {})
    {
      type: "A",
      content: "8.8.8.8",
      ttl: 600,
    }.merge(attributes)
  end

  require "securerandom"
  def random_uuid
    SecureRandom.uuid
  end
end
