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

  it{ should have_one :facebook_account }

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

  context 'create profile from facebook' do
    let(:user){ FactoryGirl.create(:user, email: 'some-email@email.com') }
    let(:fb_details){{ id: '11212233243', email: 'some-email@email.com',
                       first_name: 'some-name', last_name: 'some-surname',
                       username: 'some-username', verified: true }}

    it{ expect(user.create_profile_from_fb(fb_details)).to be_true }

    it 'create profile from facebook' do
      user.create_profile_from_fb(fb_details)
      expect(user.facebook_account.identifier).to eq(fb_details[:id])
    end

    it 'won\'t create facebook profile without a ID' do
      user.create_profile_from_fb(fb_details.merge(id: ''))
      expect(user.facebook_account).to be_nil
    end
  end
end
