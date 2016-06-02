 require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:prop_user_id) {'5'}
	let(:prop_content) {'This is content'}



	context "validation: " do
		it { is_expected.to validate_presence_of(:user_id) }
		it { is_expected.to validate_presence_of(:content) }
	end

	context "create" do
		it "can create a post" do 
			expect{ Post.create(user_id: prop_user_id, content: prop_content)}.not_to raise_error
		end
		it "can create multiple posts from same user" do
			Post.create(user_id: prop_user_id, content: prop_content)
			expect{ Post.create(user_id: prop_user_id, content: prop_content)}.not_to raise_error
		end
	end
end
