require 'will_paginate/array'
require 'pp'
class HomeController < ApplicationController
  def index
  end

  def search
    if params[:scope].blank?
      filters = {}
    else
      filters = {"only_for_#{params[:scope]}".to_sym => true}
    end
    pp filters
    @results = User.fulltext_search(params[:q], filters).paginate(page: params[:page], per_page: 10)
  end
end
