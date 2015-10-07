require 'spec_helper'

describe SessionsController do
  describe 'routing' do
    it 'routes to register' do
      get('/register').should route_to('people#new')
    end

    it 'routes to login' do
      get('/login').should route_to('sessions#new')
    end

    it 'routes to logout' do
      get('/logout').should route_to('sessions#destroy')
    end
  end
end
