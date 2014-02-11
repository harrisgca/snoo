require 'rubygems'
require 'bundler/setup'

require 'http'
require 'multi_json'

module Snoo
  class Request
    attr_reader :response, :time, :body, :json
    def initialize method, url, headers: {}, **options
      client = HTTP.with_headers(headers)
      @response = client.send(method, url.to_s, options).response
      @time = Time.now
      @body = @response.body
      @json = MultiJson.load(@response.body) if @response.headers['Content-Type'] =~ %r{application/json}
    end
  end
end
