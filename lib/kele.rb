require 'httparty'

class Kele
    include HTTParty
    
    def initialize(email, password)
        @base_uri = 'https://www.bloc.io/api/v1'
        response = self.class.post("#{@base_uri}/sessions", body: { email: email, password: password } )
        response && response['auth_token'] ? (@auth_token = response['auth_token']) : (puts "Wrong username and password, please try again.")
    end
end
