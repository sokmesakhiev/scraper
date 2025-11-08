VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true

  config.default_cassette_options = {
    record: :once,
    match_requests_on: %i[method uri body query] # Ensuring method, URI, body, and query are used for matching
  }
end
