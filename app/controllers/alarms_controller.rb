class AlarmsController < ApplicationController
  def index
    @alarms = Alarm.all
  end

  def new
    @alarm = Alarm.new
  end

  def create
    @alarm = Alarm.new(alarm_params)
    @alarm.from = ENV['TWILIO_FROM_NUMBER']
    @alarm.to = ENV['TWILIO_TO_NUMBER']
    if @alarm.save
      flash[:notice] = "Your message was sent!"
      redirect_to alarms_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  private

  def alarm_params
    params.require(:alarm).permit(:kaiju, :location, :to, :from, :body, :status)
  end
end
