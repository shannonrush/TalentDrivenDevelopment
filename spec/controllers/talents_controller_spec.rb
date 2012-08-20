require 'spec_helper'

describe TalentsController do
  let(:other_talent) {FactoryGirl.create(:talent, email: "shannonmrush@gmail.com")}
  describe '#check_authorization' do
    it 'should redirect to sign in if no current user' do
      get :edit
      response.should redirect_to(new_user_session_path)
    end 
    it 'should redirect to current user edit path if trying to edit another user' do
      sign_in(talent)
      get :edit, id:other_talent
      response.should redirect_to(edit_talent_path(talent))
    end
    it 'should not redirect if current user is user' do
      sign_in(talent)
      get :edit, id:talent
      response.should_not be_redirect
      response.should be_successful
    end
  end
  describe '#update' do
    it 'should redirect talent to talent dashboard path upon update' do
      sign_in(talent)
      put :update, {id:talent.id}
      response.should redirect_to(talent_dashboard_path(talent))
    end
  end

end
