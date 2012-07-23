require 'spec_helper'

describe OffersController do
  let(:offer) {FactoryGirl.create(:offer)}
  describe '#new' do
    it 'should redirect to sign in if no current user' do
      get :new 
      response.should redirect_to new_user_session_path
    end
  end
  describe '#create' do
    before(:each) do
      sign_in(agent)
    end
    it 'should redirect to sign in if no current user' do
      sign_out(agent)
      post :create,{:offer => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should redirect_to new_user_session_path     
    end
    it 'should create an offer' do
      post :create,{:offer => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      Offer.count.should equal 1
    end
    it 'should send one email' do
      ActionMailer::Base.deliveries = []
      post :create,{:offer => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      ActionMailer::Base.deliveries.count.should equal 1
    end
    it 'should redirect to offers_path with success notice if saved' do
      post :create,{:offer => {talent_id:talent.id,agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should redirect_to offers_path
      flash[:notice].should match "Offer sent!"
    end
    it 'should render new if invalid' do
      post :create,{:offer => {agent_id:agent.id,entity:"Some Co.",description:"A great job!"}} 
      response.should render_template("new")
    end
  end
  describe '#index' do
    it 'should redirect to sign in if no current user' do
      get :index 
      response.should redirect_to new_user_session_path
    end 
  end
  describe '#edit' do
    it 'should redirect to sign in if no current user' do
      get :edit
      response.should redirect_to new_user_session_path
    end
    it 'should redirect to user dashboard if user is not offer talent' do
      other_talent = FactoryGirl.create(:talent, :email => "other@talentdrivendevelopment.com")
      sign_in(other_talent)
      get :edit, id:offer.id
      response.should redirect_to talent_dashboard_path(other_talent)
      flash[:notice].should match "This does not appear to be your offer. Please try again."
    end
    it 'should redirect to user dashboard if offer has already been updated' do
      sign_in(offer.talent)
      offer.update_column(:acceptable,true)
      offer.update_column(:accepted,true)
      get :edit, id:offer.id
      response.should redirect_to talent_dashboard_path(offer.talent)
      flash[:notice].should match "You have already responded to this offer."  
    end
    it 'should not redirect if offer has not been updated' do
      sign_in(offer.talent)
      get :edit, id:offer.id
      response.should_not be_redirect 
    end
  end
  describe '#update' do
    it 'should redirect to sign in if no current user' do
      put :update 
      response.should redirect_to new_user_session_path
    end 
    it 'should redirect to user dashboard if user is not offer talent' do
      other_talent = FactoryGirl.create(:talent, :email => "other@talentdrivendevelopment.com")
      sign_in(other_talent)
      put :update,id:offer.id
      response.should redirect_to talent_dashboard_path(other_talent)
      flash[:notice].should match "This does not appear to be your offer. Please try again."
    end
    it 'should redirect to user dashboard if offer has already been updated' do
      sign_in(offer.talent)
      offer.update_column(:acceptable,true)
      offer.update_column(:accepted,true)
      put :update, id:offer.id
      response.should redirect_to talent_dashboard_path(offer.talent)
      flash[:notice].should match "You have already responded to this offer."  
    end
    it 'should not redirect if offer has not been updated' do
      sign_in(offer.talent)
      put :update, id:offer.id
      response.should_not be_redirect 
    end
    it 'should update acceptable and accepted' do
      sign_in(offer.talent)
      put :update,id:offer.id,offer:{accepted:true,acceptable:true}
      offer.reload
      offer.acceptable.should_not be_nil
      offer.accepted.should_not be_nil
    end
    it 'should send one email' do
      ActionMailer::Base.deliveries = []
      offer = FactoryGirl.create(:offer_no_after_create)
      sign_in(offer.talent)
      put :update,id:offer.id,offer:{accepted:true,acceptable:true}
      ActionMailer::Base.deliveries.count.should equal 1
    end
    it 'should redirect to talent dashboard path upon successful update' do
      sign_in(offer.talent)
      put :update,id:offer.id,offer:{accepted:true,acceptable:true}
      response.should redirect_to talent_dashboard_path(offer.talent)
      flash[:notice].should match "Your offer has been updated and your agent has been notified"
    end
    it 'should render edit if offer is invalid' do
      sign_in(offer.talent)
      put :update,id:offer.id,offer:{accepted:true}
      response.should render_template("edit")
    end
  end

end
