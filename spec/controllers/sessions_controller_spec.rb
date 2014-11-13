require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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
      expect(response).to render_template('layouts/sessions')
    end
  end

  context 'create session' do
    before :each do
      request.env['HTTPS'] = 'on'
    end

    let(:user_session){ double('UserSession', user: double(screen_name: 'some-screen-name')) }

    context 'through normal sign-in' do
      let(:login_details){ { email: 'some-email-id', password: 'some-password' } }
      before(:each){ expect(UserSession).to receive(:new).with(login_details).and_return(user_session) }

      it 'redirects to homepage for valid session' do
        expect(user_session).to receive(:valid?).and_return(true)
        post :create, login_details

        expect(response).to redirect_to(profile_path(user_session.user.screen_name))
      end

      it 'render to login page for invalid session' do
        expect(user_session).to receive(:valid?).and_return(false)
        post :create, login_details

        expect(response).to render_template('new')
      end
    end

    context 'through facebook sign-in' do
      let(:fb_details){ {identifier: 'some-id',
                         email: 'some-email@email.com',
                         first_name: 'some-name',
                         last_name: 'some-surname',
                         username: 'some-username'} }

      it 'returns status 201 for valid facebook sign-in' do
        expect(UserSession).to receive(:new).with({}, fb_details.stringify_keys).and_return(user_session)
        expect(user_session).to receive(:valid?).and_return(true)
        xhr :post, :create, fb_session: fb_details

        expect(response.status).to eq(201)
      end

      context 'first time' do
        subject{ xhr :post, :create, fb_session: fb_details }
        specify{ expect{ subject }.to change{ User.count }.by(1) }
        specify{ expect{ subject }.to change{ FacebookAccount.count }.by(1) }
      end
    end
  end

  context 'destroy' do
    before :each do
      request.env['HTTPS'] = 'on'
    end

    it 'redirect to home page if logged in' do
      session[:screen_name] = 'some-screen-name'
      allow(controller).to receive(:logged_in?).and_return(true)

      get :destroy
      expect(session[:screen_name]).to be_nil
      expect(response).to redirect_to(root_url(secure: false))
    end

    it 'redirect to login page if not logged in' do
      get :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end
