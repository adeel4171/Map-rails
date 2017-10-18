class MarkersController < ApplicationController
  skip_before_action :verify_authenticity_token
	before_action :authenticate_user!
  load_and_authorize_resource
  autocomplete :user, :email

	def index

      @marker = Marker.new
      @invitation = Invitation.new
      flash[:success] = ''
      if current_user.roles.first.name == "admin"
        @markers = Marker.all.to_a
      else
        @markers = current_user.markers
      end
      # @q = Marker.ransack(params[:q])
      # @markers = @q.result

      # if current_user.roles.first.name != "admin"
      #   @markers = @markers.where(user_ids: current_user.id).to_a
      # else
      #   @markers = @markers.to_a
      # end

      if session[:code].present?
        trip = Marker.where(id: session[:code]).first
        trip.join
        unless current_user.markers.include? :trip
           current_user.markers << trip
            unless trip.pending.include? current_user.id
              trip.pending << current_user.id
              trip.save!
            end
            session[:code] = ''
        end
      end
  end

  def show

    @users = Marker.users.where(id: current_user.id)
    respond_to do |format|
      format.js {}
    end
  end

  def approve_member

    trip = Marker.find(params[:trip][:trip_id])
    user_id = User.find_by(email: params[:trip][:email]).id

    trip.pending.delete(user_id)
    trip.active << user_id
    trip.save!
  end

  def reject_member

    puts 'Inside Reject Member function'

    trip = Marker.find(params[:trip][:trip_id])
    user = User.find_by(email: params[:trip][:email])
    trip.pending.delete(user.id)
    trip.user_ids.delete(user.id)
    user.marker_ids.delete(trip.id)
    trip.save!
    user.save!

  end

	def create

    @marker = Marker.new(marker_params)
    @marker.user_ids << current_user.id
    respond_to do |format|
      if @marker.save
        format.html {redirect_to tracks_path}
        format.js {flash[:success] = "Trip has been Created!"}
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
      format.js {flash[:notice] = "Trip has been Deleted!"}
    end
  end

  def invite

    @trip = Marker.find(params[:id])
    @start = @trip.location_from.split(',')
    @start = @start[-2] + @start[-1].to_s
    @end = @trip.location_to.split(',')
    @end = @end[-2] + @end[-1].to_s
    if Invitation.where(user_id: current_user.id, marker_id: @trip.id).present?
       @invitation = Invitation.find_by(user_id: current_user.id, marker_id: @trip.id)
    else
       @invitation = Invitation.new
    end

    respond_to do |format|
      format.js {}
    end
  end

  # def partial
  #
  #   @flag = params[:flag]
  #   respond_to do |format|
  #     format.js {}
  #   end
  # end

	private

	def marker_params
		params.require(:marker).permit(:from_latitude,:from_longitude,:to_latitude,:to_longitude,:location_from,:location_to,:user_ids, :departure_date, :begin_at, :end_at, :pending => [])
	end

end
