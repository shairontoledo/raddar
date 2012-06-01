require 'will_paginate/array'

class HomeController < ApplicationController
  def index
  end

  def search
    @results = User.fulltext_search(params[:q]).paginate(page: params[:page], per_page: 10)
  end
end
