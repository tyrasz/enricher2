class OfficeHoursController < ApplicationController
  def index
    start_date = params.fetch(:start_time, Date.today).to_date
    @office_hours = policy_scope(OfficeHour)
  end

  def new
    @office_hour = OfficeHour.new
    authorize @office_hour
  end

  def create
    @office_hour = OfficeHour.new(office_hour_params)
    @office_hour.user = current_user
    authorize @office_hour
    if @office_hour.save
      redirect_to office_hours_path, alert: "Created new office hour"
    else
      render :new
    end
  end

  def edit
    @office_hour = OfficeHour.find(params[:id])
    authorize @office_hour
  end

  def update
    @office_hour = OfficeHour.find(params[:id])
    authorize @office_hour
    if @office_hour.update(office_hour_params)
      redirect_to office_hours_path, alert: "Edited office hour"
    else
      render :edit
    end
  end

  private

  def office_hour_params
    params.require(:office_hour).permit(:start_time)
  end
end
