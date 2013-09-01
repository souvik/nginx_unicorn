require 'spec_helper'

describe SessionsController do
  describe 'routing' do
    context '/login' do
      specify{ expect(get: '/login').to be_routable }
      specify{ expect(get: '/login').to route_to('sessions#new') }
    end

    context '/sessions/new' do
      specify{ expect(get: '/sessions/new').not_to be_routable }
    end

    context '/sessions/create' do
      specify{ expect(post: 'create').to route_to('sessions#create') }
    end
  end

  context 'new' do
    it 'renders new template' do
      request.env['HTTPS'] = 'on'
      get :new
      expect(response).to render_template('new')
    end
  end

  context 'create' do
    before :each do
      request.env['HTTPS'] = 'on'
    end

    let(:user_session){ double('UserSession', user: double(screen_name: 'some-screen-name')) }
    let(:login_details){ { email: 'some-email-id', password: 'some-password' } }

    it 'redirects to homepage for valid session' do
      expect(UserSession).to receive(:new).with(login_details[:email], login_details[:password]).and_return(user_session)
      expect(user_session).to receive(:valid?).and_return(true)
      post :create, login_details

      expect(response).to redirect_to(profile_path(user_session.user.screen_name))
    end

    it 'render to login page for invalid session' do
      expect(UserSession).to receive(:new).with(login_details[:email], login_details[:password]).and_return(user_session)
      expect(user_session).to receive(:valid?).and_return(false)
      post :create, login_details

      expect(response).to render_template('new')
    end
  end
end
