class TemplateController < ApplicationController
  def index
    if params[:code].present?
      session[:code] = params[:code]
      if current_user.present?
        redirect_to markers_path
      end
    end
  end
end
