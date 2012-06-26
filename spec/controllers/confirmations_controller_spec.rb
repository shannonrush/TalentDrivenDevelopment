require 'spec_helper'

describe ConfirmationsController do
  let(:unconfirmed_agent) {FactoryGirl.create(:agent,confirmed_at:nil)}
  let(:unconfirmed_talent) {FactoryGirl.create(:talent,confirmed_at:nil)}
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  it 'should set user confirmation_token to nil and set confirmed_at upon using confirmation link from registration email' do
    get :show,{confirmation_token:unconfirmed_agent.confirmation_token}
    unconfirmed_agent.reload
    unconfirmed_agent.confirmation_token.should be_nil
    unconfirmed_agent.confirmed_at.should_not be_nil
  end
  it 'should redirect agent to edit agent path after confirmation' do
    get :show,{confirmation_token:unconfirmed_agent.confirmation_token}
    response.should redirect_to(edit_agent_path(unconfirmed_agent))
  end
  it 'should redirect talent to edit talent path after confirmation' do
    get :show,{confirmation_token:unconfirmed_talent.confirmation_token}
    response.should redirect_to(edit_talent_path(unconfirmed_talent))
  end
end