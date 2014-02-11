require 'rubygems'
require 'bundler/setup'

module Snoo
  class Client

    include Account

    # @!attribute base_url
    #   The url endpoint in use
    #   @return [String] The url
    # @!attribute headers
    #   The HTTP headers sent with every request
    #   @return [Hash] A hash of the HTTP headers
    # @!attribute user_agent
    #   The user agent
    #   @return [String] The current user agent
    attr_accessor :base_url, :headers, :user_agent

    # @!attribute [r] user
    #   The current user
    #   @return [User] User
    # @!attribute [r] modhash
    #   The current modhash
    #   @return [String] Modhash
    # @!attribute [r] cookies
    #   The Current cookies
    #   @return [String] cookies
    attr_reader :user, :modhash, :cookies

    # Create a new instance of Snoo::Client
    # @param  url:        [String] The URL endpoint to use
    # @param  user_agent: [String] The default user agent sent to reddit. Recommended to change this to something custom
    # @param  username:   [String] The username to auth
    # @param  password:   [String] The password to auth (for use with username)
    # @param  modhash:    [String] The modhash to use for auth
    # @param  cookies:    [String] The cookies to use for auth (for usse with modhash)
    # @param  **options   [Hash]   Any extra options will be passed as headers
    # 
    # @return [Snoo::Client] An instance of Snoo::Client
    def initialize(url: "http://www.reddit.com", user_agent: "snoo api wrapper v#{VERSION}", username: nil, password: nil, modhash: nil, cookies: nil, throttle: 2, **options)
      @base_url = URI.parse(url)
      @user_agent = user_agent
      @headers = { 'User-Agent' => user_agent, 'Accept' => 'application/json' }.merge(options)
      if !(username.nil? && password.nil?)
        self.log_in username: username, password: password
      elsif !(modhash.nil? && cookies.nil?)
        self.auth modhash: modhash, cookies: cookies
      end
    end

    private
    def set_cookies cookies
      @cookies = cookies
      @headers['Cookie'] = cookies
    end

    def request method, url, headers: {}, **options
      if !@last_request.nil? && Time.now - @last_request.time >= @throttle
        @last_request = Snoo::Request.new(method, url, headers: headers, **options)
      elsif @last_request.nil?
        @last_request = Snoo::Request.new(method, url, headers: headers, **options)
      end
    end

    def get path, headers: {}, **options
      url = URI.join(@base_url, path)
      header = @headers.merge(headers)
      request :get, url, headers: header, **options
    end

    def post path, headers: {}, **options
      url = URI.join(@base_url, path)
      header = @headers.merge(headers)
      request :post, url, headers: header, **options
    end
  end
end
