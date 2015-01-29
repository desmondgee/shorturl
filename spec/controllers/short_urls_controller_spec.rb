describe ShortUrlsController do
  describe 'POST #create' do
    
    context 'when forward url is blank' do
      it 're-renders page with error' do 
        post :create, {forward:""}
        expect(response).to render_template(:new)
        expect(flash[:errors]).first.to match(/^Forward url cannot be blank/)
      end
    end
    
    context 'when forward url is just spaces' do
      it 're-renders page with error' do 
        post :create, {forward:"   "}
        expect(response).to render_template(:new)
        expect(flash[:errors]).first.to match(/^Forward url cannot be blank/)
      end
    end
    
    context 'when forward url is valid' do
      it 're-renders page with shortened url' do
        post :create, {forward:"www.google.com"}
        expect(response).to render_template(:new)
        assigns(:short_code).should_not be_empty
      end
    end
    
  end
  
  describe 'GET #view' do
  
    context 'when no matching short code' do
      it 'redirects to redirects to view_error page' do
        code = "jLf24J"
        get :view
        expect(response.to redirect_to(view_short_code_error_path(code)))
        assigns(:code).should eq(code)
      end
    end
    
    context 'when found matching short code' do
      it 'redirects to corresponding forwarding url'  do
        forward = forward
        short = ShortUrl.create(:forward=>forward)
        code = short.code
        get goto_short_url_path(code)
        expect(response.to redirect_to(forward))
      end
    end
  
  end
  
  describe 'GET #view_error' do
  
    context 'when no short code is given' do
      it 'render invalid short code page' do
        get :view_error 
        expect(response).to render_template(:new)
        assigns(:code).should eq("")
      end
    end
    
    context 'when short code given' do
      it 'render invalid short code page'  do
        code = "5jmIA"
        get view_short_url_error_path(code)
        expect(response).to render_template(:new)
        assigns(:code).should eq(code)
      end
    end
  
  end
  
  
  
end
