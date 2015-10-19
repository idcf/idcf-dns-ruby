# Idcf::Dns
[![Gem Version](https://badge.fury.io/rb/idcf-dns.svg)](http://badge.fury.io/rb/idcf-dns)
[![Build Status](https://travis-ci.org/idcf/idcf-dns-ruby.svg?branch=master)](https://travis-ci.org/idcf/idcf-dns-ruby)
[![Code Climate](https://codeclimate.com/github/idcf/idcf-dns-ruby/badges/gpa.svg)](https://codeclimate.com/github/idcf/idcf-dns-ruby)
[![Test Coverage](https://codeclimate.com/github/idcf/idcf-dns-ruby/badges/coverage.svg)](https://codeclimate.com/github/idcf/idcf-dns-ruby/coverage)

A Ruby client for [IDCF Cloud DNS service](http://www.idcf.jp/cloud/dns/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'idcf-dns'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install idcf-dns

## Usage
### Basic usage
#### Client
```ruby
require "idcf/dns"

client =
  Idcf::Dns::Client.new(
    api_key: ENV["IDCF_API_KEY"],
    secret_key: ENV["IDCF_SECRET_KEY"]
  )

# Call GET request directly
# returns Response object
response = client.get("zones")
response.success? #=> true
response.status   #=> 200

# Response#body returns HTTP response body as a hash or an array
response.body     #=> [zone1, zone2, ...]
response.body[0]  #=> zone1

# Response#[] is alias to Response#body[]
response[0]       #=> zone1
```

#### Zones
##### Create new zone
```ruby
response =
  client.create_zone(
    name: "foobar.example.com",
    email: "foobar@example.com",
    description: "description",
    default_ttl: 600
  )

response.uuid #=> UUID of new zone
```

##### Get zones
```ruby
# Get all zones
zones = client.list_zones.body
zones[0]["name"] #=> "foobar.example.com"

# Get a zone
zone = client.get_zone(zone_uuid).body
zone["name"]         #=> "foobar.example.com"
zone["records"].size #=> 3
```

##### Update zone
```ruby
client.update_zone(zone_uuid, description: "Updated")
```

##### Delete zone
```ruby
client.delete_zone(zone_uuid)
```

#### Records
##### Create new record
```ruby
response =
  client.create_record(
    zone_uuid,
    name: "baz.foobar.example.com",
    type: "A",
    content: "8.8.8.8",
    ttl: 600
  )

response.uuid #=> UUID of new record
```

##### Get records
```ruby
# Get all records of a zone
records = client.list_records(zone_uuid).body
records[0]["name"] #=> "baz.foobar.example.com"

# Get a record
record = client.get_record(zone_uuid, record_uuid).body
record["name"] #=> "baz.foobar.example.com"
```

##### Update record
```ruby
client.update_record(zone_uuid, record_uuid, content: "210.140.158.1")
```

##### Delete record
```ruby
client.delete_record(zone_uuid, record_uuid)
```

### Advanced usage
#### Custom expiration of requests
In default, requests will expire in 600 seconds.
You can use custom expirations for each request.

```ruby
expiration = Time.now.to_i + 10

client.list_zones("X-IDCF-Expires": expiration).success?
#=> true

# wait for 10 seconds ...

client.list_zones("X-IDCF-Expires": expiration)
#=> Idcf::Dns::ApiError: HTTP status code: 403, Error message: This api request is expired., Reference: http://docs.idcf.jp/cloud/dns
```

### API reference
http://www.rubydoc.info/gems/idcf-dns

## Contributing

1. Fork it ( https://github.com/idcf/idcf-dns-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
