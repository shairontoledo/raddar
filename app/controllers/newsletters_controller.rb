class NewslettersController < ApplicationController
  load_and_authorize_resource
  
  def show
    respond_with @newsletter
  end

end
