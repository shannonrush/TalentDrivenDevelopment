require 'spec_helper'

describe RegistrationsController do
  it 'should create a user upon sign up form submission' do
    User.delete_all
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post 'create',{"authenticity_token"=>"D3UA0RDpjoiY1j4wHVb9sfRGorRWw3gnT7iGX8l1Tac=", "user"=>{"email"=>"shannonmrush@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "type"=>"agent"}
    User.where(email:"shannonmrush@gmail.com").count.should equal 1
  end
  it 'should create Agent with agent type submission' do
    User.delete_all
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post 'create',{"authenticity_token"=>"D3UA0RDpjoiY1j4wHVb9sfRGorRWw3gnT7iGX8l1Tac=", "user"=>{"email"=>"shannonmrush@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "type"=>"agent"}
    Agent.count.should equal 1
    Talent.count.should equal 0
  end
  it 'should create Talent with talent type submission' do
    User.delete_all
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post 'create',{"authenticity_token"=>"D3UA0RDpjoiY1j4wHVb9sfRGorRWw3gnT7iGX8l1Tac=", "user"=>{"email"=>"shannonmrush@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "type"=>"talent"}
    Agent.count.should equal 0
    Talent.count.should equal 1
  end
  it 'should send registration email upon registration' do
    ActionMailer::Base.deliveries = []
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post 'create',{"authenticity_token"=>"D3UA0RDpjoiY1j4wHVb9sfRGorRWw3gnT7iGX8l1Tac=", "user"=>{"email"=>"shannonmrush@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "type"=>"agent"}
    ActionMailer::Base.deliveries.count.should equal 1
    mail = ActionMailer::Base.deliveries.last
    mail['subject'].to_s.should match "Welcome to Talent Driven Development!"
  end
  it 'should send registration email with agent text for Agent type' do
    ActionMailer::Base.deliveries = []
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post 'create',{"authenticity_token"=>"D3UA0RDpjoiY1j4wHVb9sfRGorRWw3gnT7iGX8l1Tac=", "user"=>{"email"=>"shannonmrush@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "type"=>"agent"}
    mail = ActionMailer::Base.deliveries.last
    mail.body.to_s.include?("We are so excited to have you as part of our talent agent team!  Please confirm your account and be sure to fill out your agent profile - that is how talent can find and learn about you!").should be_true
  end
  it 'should send registration email with talent text for Talent type' do
    ActionMailer::Base.deliveries = []
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post 'create',{"authenticity_token"=>"D3UA0RDpjoiY1j4wHVb9sfRGorRWw3gnT7iGX8l1Tac=", "user"=>{"email"=>"shannonmrush@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "type"=>"talent"}
    mail = ActionMailer::Base.deliveries.last
    mail.body.to_s.include?("We are so excited you've decided to try Talent Driven Development! We hope it will help minimize the annoying parts of managing your career so you can concentrate on what you enjoy.").should be_true
  end
end