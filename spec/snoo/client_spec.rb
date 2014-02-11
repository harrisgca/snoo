require "spec_helper"

describe Snoo::Client do
  describe "#initialize" do
    context "with no paramiters" do
      it "creates a default client" do
        client = Snoo::Client.new
        client.base_url.to_s.should eq("http://www.reddit.com")
        client.headers.should eq({"User-Agent"=>"snoo api wrapper v1.0.0", "Accept"=>"application/json"})
        client.user_agent.should eq("snoo api wrapper v#{Snoo::VERSION}")
        client.modhash.should be(nil)
        client.cookies.should be(nil)
      end
    end
  end
end
