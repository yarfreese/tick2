require 'spec_helper'

describe ProjectsController do
  let(:user) { FactoryGirl.create(:user) }

  context "standard users" do
    before do
      sign_in(user)
    end

    #it "cannot access the new action" do
      #get :new
      #expect(response).to redirect_to('/')
      #expect(flash[:alert]).to eql("You must be an admin to do that.")
    #end
    { new: :get,
      create: :post,
      edit: :get,
      update: :put,
      destroy: :delete  }.each do |action, method|
      it "cannot access the #{action} action" do
        sign_in(user)
        send(method, action, :id => FactoryGirl.create(:project))
        
        expect(response).to redirect_to('/')
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end
    end
  end

  it "displays an error for a missing project" do
    get :show, :id => "not-here"
    expect(response).to redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    expect(flash[:alert]).to eql(message)
  end
end
