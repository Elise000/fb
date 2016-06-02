require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "redirects to root if already logged in" do
      user = User.create!(name: "test_name", email: "test@mail.com")
      session[:current_user_id] = user.id
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #create" do
    context "valid login" do
      before do
        post :create, :user => { id: 1, name: "test_name", email: "test@mail.com" }
      end
    end

    it "creates user session" do
      expect(controller).to set_session[:current_user_id]
      expect(session[:current_user_id]).to eq assigns[:user].id
    end

    it "redirects to the root path if user is created" do
      expect(response).to redirect_to(root_path)
    end
      it "shows email error message" do
        expect(controller).to set_flash[:notice]
        expect(flash[:notice]).to eq "Email invalid"
      end
  end

  describe "GET #delete" do
    before do
      post :create, :user => { name: "test_name", email: "test_email@nextacademy.com" }
      delete :destroy
    end
    it "sets session to nil when user logs out" do
      expect(session[:current_user_id]).to eq nil
    end

    it "redirects back to to sessions path if user logs out" do
      expect(response).to redirect_to(sessions_path)
    end
    it "shows logged out message" do
      expect(flash[:notice]).to eq "Logged out."
    end
  end

end
