describe ShortUrlsController, type: :controller do
  describe 'POST #create' do
    
    context 'when forward url is blank' do
      it 're-renders page with error' do 
        post :create, {short_url:{forward:""}}
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to match(/^Forward url cannot be blank/)
      end
    end
    
    context 'when forward url is just spaces' do
      it 're-renders page with error' do 
        post :create, {short_url:{forward:"   "}}
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to match(/^Forward url cannot be blank/)
      end
    end
    
    context 'when forward url is valid' do
      it 're-renders page with shortened url' do
        post :create, {short_url:{forward:"www.google.com"}}
        expect(response).to redirect_to(root_path)
        expect(flash[:short_url]).to be_present
      end
    end
    
  end
  
  describe 'GET #view' do
  
    context 'when no matching short code' do
      it 'redirects to redirects to view_error page' do
        code = "jLf24J"
        get :goto, :code => code
        expect(response).to redirect_to(view_short_url_error_path(code))
        get :view_error, :code => code
        expect(assigns(:code)).to eq(code)
      end
    end
    
    context 'when found matching short code' do
      it 'redirects to corresponding forwarding url'  do
        forward = 'http://www.google.com'
        short = ShortUrl.create(:forward=>forward)
        code = short.code
        get :goto, :code => code
        expect(response).to redirect_to(forward)
      end
    end
  
  end
  
  describe 'GET #view_error' do
  
    context 'when no short code is given' do
      it 'render invalid short code page' do
        get :view_error
        expect(response).to render_template(:view_error)
        expect(assigns(:code)).to be_nil
      end
    end
    
    context 'when short code given' do
      it 'render invalid short code page'  do
        code = "5jmIA"
        get :view_error, :code =>code
        expect(response).to render_template(:view_error)
        expect(assigns(:code)).to eq(code)
      end
    end
  
  end
  
  
  
end
