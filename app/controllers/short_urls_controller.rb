require "ShortUrl"

class ShortUrlsController < ApplicationController
  layout "application"
  
  def create
    create_params = params.require(:short_url).permit(:forward)
    if (create_params[:forward].present?) 
      short_url = ShortUrl.create!(create_params)
      redirect_to root_path, :flash => {:short_url => {:forward=>short_url.forward, :code=>short_url.code}}
    else 
      redirect_to root_path, :flash => {:error => 'Forward url cannot be blank'}
    end
  end
  
  def goto
    code = params[:code]
    id = ShortUrl.codeToId(code)
    if id.nil?
      redirect_to view_short_url_error_path(code)
    else
      forward = ShortUrl.find(id).forward
      
      if (forward.slice(0,7) == "http://" || forward.slice(0,8) == "https://") 
        redirect_to forward
      else
        redirect_to "http://" + forward
      end
    end
  end
  
  def view_error
    @code = params[:code]
    render
  end
  
end
