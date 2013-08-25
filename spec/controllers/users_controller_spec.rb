require 'spec_helper'

describe UsersController do
  context 'routing' do
    specify{ expect(get: '/users/new').to route_to('users#new') }
    specify{ expect(post: '/users').to route_to('users#create') }
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

  context 'create' do
    context 'with valid attributes' do
      let(:valid_attrs){ FactoryGirl.attributes_for(:user).merge(password: '123456', password_confirmation: '123456').stringify_keys }

      it 'create a new user' do
        expect{post :create, user: valid_attrs }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, user: valid_attrs
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to the profile page' do
        post :create, user: valid_attrs
        expect(response).to redirect_to(profile_path(User.last))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attrs){ {'first_name' => '', 'last_name' => 'xxx'} }

      before :each do
        User.any_instance.stub(:save).and_return(false)
      end

      it 'assigns a newly create but unsaved user as @user' do
        post :create, user: invalid_attrs
        expect(assigns(:user)).to be_a_new(User)
      end

      it 're-renders the \'new\' template' do
        post :create, user: invalid_attrs
        expect(response).to render_template('new')
      end
    end
  end
end
