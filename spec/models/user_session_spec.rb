require 'rails_helper'

RSpec.describe UserSession do
  context 'validator' do
    context 'for normal session' do
      before :each do
        FactoryGirl.create(:user, email: 'some-email@example.com', password: 'some-password')
      end

      it 'should say invalid for anonymous user' do
        expect(UserSession.new({ email: 'wrong-email@example.com', password: 'wrong-password'})).not_to be_valid
      end

      it 'should say valid for matched user' do
        expect(UserSession.new({ email: 'some-email@example.com', password: 'some-password' })).to be_valid
      end
    end

    context 'for facebook session' do
      subject{ UserSession.new({}, {identifier: 'some-id', first_name: 'some-name', last_name: 'some-surname',
                                    email: 'some-email@email.com', username: 'some-username', verified: true}) }

      it 'returns true when first time login' do
        expect(subject.valid?).to be_truthy
      end
    end
  end

  context 'facebook session validator' do
    subject{ UserSession.new({}, { identifier: '100000179221741',
                                   email: 'some-email',
                                   first_name: 'some-name',
                                   last_name: 'some-surname',
                                   username: 'fb-username',
                                   verified: true }) }

    context '1st time login through facebook' do
      #its('user'){ should be_a(AnonymousUser) }
      it{ expect(subject.user).to be_a_new(AnonymousUser) }
      it{ expect(subject.fb_session_validator).to be_truthy }
    end
  end
end
