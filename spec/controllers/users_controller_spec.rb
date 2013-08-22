require 'spec_helper'

describe UsersController do
  context 'routing' do
    specify{ expect(get: '/users/new').to route_to('users#new') }
  end

  context 'new' do
    it 'renders new template with users layout' do
      get :new
      expect(response).to render_template('new')
      expect(response).to render_template('layouts/users')
    end

    it 'should create new user' do
      expect(User).to receive(:new)
      get :new

      expect(response).to be_success
    end
  end
end
