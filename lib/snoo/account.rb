module Snoo
  module Account

    # Attempts to log into reddit with the current user
    # @param  username: [String] The username
    # @param  password: [String] The password
    # 
    # @return [User] A user object representing the current user
    def login(username:, password:)
      login = post("/api/login", form: {user: username, passwd: password, api_type: 'json'})
      errors = login.json['json']['errors']
      raise errors[0][1] unless errors.size == 0
      set_cookies login.response.headers['Set-Cookie']
      @modhash = login.json['json']['data']['modhash']
      @user = Snoo::User.new(me)
    end
  end
end
