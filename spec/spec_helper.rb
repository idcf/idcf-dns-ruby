require "simplecov"
SimpleCov.start do
  add_filter "vendor"
  add_filter "spec"
end

if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'idcf/dns'

ZONES = []
TEMPLATES = []

auth_args = {
  api_key: ENV["IDCF_API_KEY"],
  secret_key: ENV["IDCF_SECRET_KEY"],
  api_key: "Y8Yt8h4teOF4Y9mhY3vF7JxSAX9oRtLtr-EsP3jQBfGf4a0-LiwEzUpbsou2SySmIV9RhoKymz0htxPOXKtvcA",
  secret_key: "8niGo36cmpPJFylN4-mj3pZskxObnjpVv40kjZjPVeMCn5yvK4kpSQUxnDHsn6QsS2QeDQ7uf6MDyDT2mJimJQ",
  host: "dns.cloud.egg.jp",
  verify_ssl: false
}

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.after(:suite) do
    client = Idcf::Dns::Client.new(auth_args)
    ZONES.reverse_each do |zone_uuid|
      client.delete_zone(zone_uuid)
    end
    TEMPLATES.reverse_each do |template_uuid|
      client.delete_template(template_uuid)
    end
  end
end

shared_context "resources" do
  let(:client) { Idcf::Dns::Client.new(auth_args) }

  def zone_attributes(attributes = {})
    {
      name: "rspec-#{ZONES.size}.idcf-dns-ruby.jp",
      email: "rspec@idcf-dns-ruby.jp",
      description: "For idcf-dns-ruby rspec",
      default_ttl: 600
    }.merge(attributes)
  end

  def record_attributes(attributes = {})
    {
      type: "A",
      content: "8.8.8.8",
      ttl: 600
    }.merge(attributes)
  end

  def template_attributes(attributes = {})
    {
      name: "rspec-#{TEMPLATES.size}.template",
      description: "For idcf-dns-ruby rspec",
      default_ttl: 600
    }.merge(attributes)
  end
end
