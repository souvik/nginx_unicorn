require 'spec_helper'

describe SessionsController do
  describe 'routing' do
    context '/login' do
      specify{ expect(get: '/login').to be_routable }
      specify{ expect(get: '/login').to route_to('sessions#new') }
    end
  end

  context 'new' do
    
  end
end
