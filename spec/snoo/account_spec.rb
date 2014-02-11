require 'spec_helper'

describe Snoo::Account do
  before(:each) do
    @client = Snoo::Client.new
  end
  describe "#login" do
    before(:each) do
      @username = Faker::Internet.user_name
      @password = Faker::Internet.password
      stub_request(:post, "http://www.reddit.com/api/login").
        with(:body => {"api_type"=>"json", "passwd"=>@password, "user"=>@username},
             :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'www.reddit.com', 'User-Agent'=>"snoo api wrapper v#{Snoo::VERSION}"}).
        to_return(:status => 200, :body => "{\"json\":{\"errors\":[],\"data\":{\"modhash\":\"Test\",\"cookie\":\"AnotherTest\"}}}",:headers => {"content-type"=>["application/json; charset=UTF-8"], "content-length"=>["179"], "cache-control"=>["no-cache"], "pragma"=>["no-cache"], "x-frame-options"=>["SAMEORIGIN"], "x-content-type-options"=>["nosniff"], "x-xss-protection"=>["1; mode=block"], "set-cookie"=>["AnotherTest"], "server"=>["'; DROP TABLE servertypes; --"], "date"=>["Tue, 11 Feb 2014 23:12:34 GMT"], "connection"=>["close"]})
    end
    it "logs in the specified user" do
      currentuser = @client.login username: @username, password: @password
      @client.modhash.should eq("Test")
      @client.cookies.should eq("AnotherTest")
    end
    it "returns @user" do
      currentuser = @client.login username: @username, password: @password
      @user.should be(User)
      currentuser.should be(User)
      pending "Test @user"
    end
  end
  describe "#logout" do
    it "clears the current client settings" do
      @client.logout
      @client.modhash.should be(nil)
      @client.cookies.should be(nil)
      @client.user.should be(nil)
    end
  end
  describe "#auth" do
    it "sets the modhash and cookies" do
      @client.auth modhash: "TestModhash", cookies: "TestCookies"
      @client.modhash.should eq("TestModhash")
      @client.cookies.should eq("TestCookies")
    end
    it "returns (and refreshes) @user" do
      currentuser = @client.auth modhash: "TestModhash", cookies: "TestCookies"
      @user.should be(User)
      currentuser.should be(User)
      pending "Test @user"
    end
  end
  describe "#clear_sessions" do
    it "clears all reddit sessions" do
      
    end
    it "updates @user" do
      
    end
  end
  describe "#me" do
    
  end
  describe "#delete_user" do
    
  end
  describe "#change_password" do
    
  end
  describe "#change_email" do
    
  end
end
