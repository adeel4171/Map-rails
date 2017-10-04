class MarkersController < ApplicationController
  skip_before_action :verify_authenticity_token
	before_action :authenticate_user!
  load_and_authorize_resource
	def index
      flash.now[:notice] = 'flash message index'
      @marker = Marker.new
      @invitation = Invitation.new
      if current_user.roles.first.name == "admin"
        @markers = Marker.all.to_a
      else
        @markers = current_user.markers
      end
  end

  def show
    @users = Marker.users.where(id: current_user.id)
    respond_to do |format|
      format.js {}
    end
  end

	def create

    @marker = Marker.new(marker_params)
    @marker.user_ids << current_user.id
    respond_to do |format|
      if @marker.save
        flash.now[:notice] = 'flash message add'
        format.html {redirect_to tracks_path}
        format.js {}
      else
        render :new
      end
    end
	end

  def destroy
    @record = Marker.find(params[:id])
    @deleted_record = @record
    @record.destroy
    respond_to do |format|
      format.js {}
    end
  end

  def invite
    puts '||||||||||||||||||||||||||||||||||||||'
    puts params.inspect
    @trip = Marker.find(params[:id])
    if Invitation.find_by(user_id: current_user.id, marker_id: @trip.id).present?
      @invitation = Invitation.find_by(user_id: current_user.id, marker_id: @trip.id)
    else
      @invitation = Invitation.new
    end

    respond_to do |format|
      format.js {}
    end
  end

	private

	def marker_params
		params.require(:marker).permit(:from_latitude,:from_longitude,:to_latitude,:to_longitude,:location_from,:location_to,:user_ids)
	end

end
