require 'spec_helper'
describe SplashController, type: :controller do  
  describe 'GET #index' do
    it 'render splash page' do 
      get :index
      expect(response).to render_template(:new)
    end
    
  end
end
