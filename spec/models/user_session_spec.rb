require 'spec_helper'

describe UserSession do
  context 'validator' do
    before :each do
      FactoryGirl.create(:user, email: 'some-email@example.com', password: 'some-password')
    end

    it 'should say invalid for anonymous user' do
      expect(UserSession.new('wrong-email@example.com', 'wrong-password')).not_to be_valid
    end

    it 'should say valid for matched user' do
      expect(UserSession.new('some-email@example.com', 'some-password')).to be_valid
    end
  end
end
