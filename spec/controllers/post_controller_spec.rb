require 'rails_helper'

RSpec.describe PostController, type: :controller do

  describe "GET #index" do
    it "redirects to Sessions#New if user isnt signed in" do
      get :index
      expect(response).to redirect_to(sessions_path)
    end
    it "renders the index template" do
      session[:current_user_id] = user.id
      get :index
      expect(response).to render_template(:index)
    end
    it "prompts user to login first" do
      get :index
      expect(controller).to set_flash[:notice]
      expect(controller).to set_flash[:notice].to(/Please login first/)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders create form" do 
      get :new
      expect(response).to render(:form)
    end
  end

  describe "POST #create" do
    it "creates a post" do
      expect{ Post.create(user_id: 1, content: "this is the one")}.not_to raise_error
    end
    it "cannot create post without user logged in" do
      post :create, :user => { id: 1, name: "test_name", email: "test@mail.com" }
      expect{ Post.create(user_id: current_user_id, content: "this is the one")}.to_not raise_error
    end
  end
  describe "GET #edit" do 
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "renders form" do
      expect(responce).to render_template(:form)
    end
  end





describe "POST #update" do
  it "edits successfully" do
      @post = Post.create(user_id: 1, content: "this is the one")
      @post.update(content: "this is the second")
      expect(@post.content).to eq("this is the second")
    end
  end
  describe "DESTROY #delete" do
    it "destroys successfully" do
      @post = Post.create(user_id: 1, content: "this is the one")
      @post.destroy
      expect(@post).to eq(nil)
    end
  end
end





