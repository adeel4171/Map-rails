class TemplateController < ApplicationController
  def index
    if params[:code].present?
      @invitation_code = params[:code ]
    end
  end
end
