require 'httparty'
require 'json'

class Kele
    include HTTParty
    include JSON
    
    def initialize(email, password)
        @base_uri = 'https://www.bloc.io/api/v1'
        response = self.class.post("#{@base_uri}/sessions", body: { email: email, password: password } )
        response && response['auth_token'] ? (@auth_token = response['auth_token']) : (puts "Wrong username and password, please try again.")
    end
    
    def get_me
        response = self.class.get("#{@base_uri}/users/me", headers: { "authorization" => @auth_token })
        @parse_user = JSON.parse(response.body)
    end
end
