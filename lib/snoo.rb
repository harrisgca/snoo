require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'data_mapper'

%w{version exceptions utilities account flair links_comments listings moderation pms subreddits users desmond_bot}.each do |local|
  require "snoo/#{local}"
end
# Snoo reddit API wrapper
#
# @author Jeff Sandberg <paradox460@gmail.com>
module Snoo
  # Snoo reddit API wrapper
  #
  # @author (see Snoo)
  class Client
    include HTTParty
    [Account, Flair, LinksComments, Listings, Moderation, PM, Utilities, User, Subreddit, DesmondBot].each do |inc|
      include inc
    end

    #harrisgca - I added the :notified variable to hold an array of post ids that I've been notified about
    attr_reader(:modhash, :username, :userid, :cookies, :notified)


    # Creates a new instance of Snoo.
    #
    # As of 0.1.0.pre.4, you can auth or log-in via initializers, saving you from having to run the log-in or auth command seperately.
    # Simply pass username-password options, OR modhash-cookie options (you cannot do both)
    #
    # @param opts [Hash] A hash of options
    # @option opts [String] :url The base url of the reddit instance to use. Only change this if you have a private reddit
    # @option opts [String] :useragent The useragent the bot uses. Please change this if you write your own complex bot
    # @option opts [String] :username The username the bot will log in as
    # @option opts [String] :password The password the bot will log in with
    # @option opts [String] :modhash The modhash the bot will auth with
    # @option opts [String] :cookies The cookie string the bot will auth with
    def initialize( opts = {} )
      options = {url: "http://www.reddit.com", useragent: "DesmondBot based on Snoo ruby reddit api wrapper v#{VERSION}" }.merge opts
      @baseurl = options[:url]
      self.class.base_uri options[:url]
      @headers = {'User-Agent' => options[:useragent] }
      self.class.headers @headers
      @cookies = nil
      @modhash = nil
      @notified = []
      @owner = 'harrisgca'

      if !(options[:username].nil? && options[:password].nil?)
        self.log_in options[:username], options[:password]
      elsif !(options[:modhash].nil? && options[:cookies].nil?)
        self.auth options[:modhash], options[:cookies]
      end
    end
  end

  class Post
    include DataMapper::Resource

    property :id, Serial
    property :post_id, String
    property :created_at, DateTime
  end
end
