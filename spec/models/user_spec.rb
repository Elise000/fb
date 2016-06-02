 require 'rails_helper'

RSpec.describe User, type: :model do
	let(:proper_name) 		{'Bobby Hanks'}
	let(:proper_email)		{ 'This@mail.com' }
	let(:improper_email)		{ 'This@mail' }
	let(:proper_password)		{ '12345678' }
	let(:improper_password)		{ '111' }


	context "validation: " do
		it { is_expected.to validate_presence_of(:name) }
		it { is_expected.to validate_presence_of(:email) }
		it { is_expected.to validate_uniqueness_of(:email) }
		it { is_expected.to allow_value(proper_email).for(:email) }
		it { is_expected.not_to allow_value(improper_email).for(:email)  }
		it { is_expected.to validate_presence_of(:password) }
		it { is_expected.to allow_value(proper_password).for(:password) }
		it { is_expected.not_to allow_value(improper_password).for(:password)  }
	end

	context "create" do
		it "cannot create without name" do
			expect{ User.create(email: proper_email, password: proper_email) }.to raise_error
		end
		it "cannot create without email" do
			expect{ User.create(name: proper_name, password: proper_email) }.to raise_error
		end
		it "cannot create without password" do
			expect{ User.create(email: proper_email, name: proper_name) }.to raise_error
		end
		it "can create with all three present" do
			expect{ User.create(name: proper_name, email: proper_email, password: proper_password)}.not_to raise_error
		end
		it "cannot create user with same email" do
			User.create(name: proper_name, email: proper_email, password: proper_password)
			expect{ User.create(name: proper_name, email: proper_email, password: proper_password)}.to raise_error
		end
	end
end
