require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'routing' do
    context '/index or /' do
      specify{ expect(get: '/').to be_routable }
      specify{ expect(get: '/').to route_to('home#index') }
    end
  end

  context 'index' do
    subject{ get :index }
    specify{ expect(subject).to be_success }
    specify{ expect(subject).to render_template('index') }
    specify{ expect(subject).to render_template('layouts/sessions') }
  end
end
