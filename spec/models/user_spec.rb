require 'spec_helper'

describe User do
  it{ should validate_presence_of :first_name }
  it{ should validate_presence_of :last_name }
  it{ should validate_presence_of :email }
  it{ should validate_presence_of :password }

  it{ should ensure_length_of(:first_name).is_at_most(60) }
  it{ should ensure_length_of(:last_name).is_at_most(60) }
  it{ should ensure_length_of(:email).is_at_most(100)}

  it{ should validate_uniqueness_of :email }

  it{ should validate_confirmation_of :password }

  context 'when authentic with password' do
    let(:user){ FactoryGirl.build(:user) }

    before :each do
      user.stub(:decrypt_password).and_return('some-password')
    end

    it 'should not return true for wrong password' do
      expect(user.authentic_user?('some-other-password')).not_to be_true
    end

    it 'should return true for correct password' do
      expect(user.authentic_user?('some-password')).to be_true
    end
  end
end
