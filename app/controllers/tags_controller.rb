require 'will_paginate/array'

class TagsController < ApplicationController
  load_and_authorize_resource

  def show

    @scopes = [:all]
    @tag.taggings.distinct(:taggable_type).each {|tt| @scopes << tt.underscore.to_sym }

    if params[:scope].blank?
      @taggings = @tag.taggings.paginate(page: params[:page], per_page: 10)
    else
      @taggings = @tag.taggings.where(taggable_type: params[:scope].camelize).paginate(page: params[:page], per_page: 10)
    end
  end
end
