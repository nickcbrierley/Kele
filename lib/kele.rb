require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
    include HTTParty
    include JSON
    include Roadmap
    
    def initialize(email, password)
        @base_uri = 'https://www.bloc.io/api/v1'
        response = self.class.post("#{@base_uri}/sessions", body: { email: email, password: password } )
        response && response['auth_token'] ? (@auth_token = response['auth_token']) : (puts "Wrong username and password, please try again.")
    end
    
    def get_me
        response = self.class.get("#{@base_uri}/users/me", headers: { "authorization" => @auth_token })
        @me = JSON.parse(response.body)
    end
    
    def get_mentor_availability(mentor_id)
        response = self.class.get("#{@base_uri}/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
        @mentor_availability = JSON.parse(response.body)
    end
    
    def get_messages(*page)
        response = self.class.get("#{@base_uri}/message_threads", headers: { "authorization" => @auth_token })
        @messages = JSON.parse(response.body)
    end
    
    def create_messages(sender, recipient_id, subject, body)
        response = self.class.post("#{@base_uri}/messages", body: {"sender" => sender, "recipient_id" => recipient_id, "subject" => subject, "stripped-text" => body }, headers: { "authorization" => @auth_token })
    end
    
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
        response = self.class.get("#{@base_uri}/checkpoint_submissions", body: {"checkpoint_id" => checkpoint_id, "assignment_branch" => assignment_branch, "assignment_commit_link" => assignment_commit_link, "comment" => comment, "enrollment_id" => enrollment_id}, headers: { "authorization" => @auth_token })
    end
end
