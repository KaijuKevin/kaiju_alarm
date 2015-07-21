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
      @alarm.body = " Kaiju: " + @alarm.kaiju + " Location: " + @alarm.location + " Body: " + @alarm.body + " Alarm ID " + @alarm.id.to_s
      @alarm.save
      @alarm.sound_alarm
      redirect_to alarms_path
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def update
    @alarm = Alarm.find(params[:id])
    @alarm.active = !@alarm.active
    @alarm.save
    redirect_to alarms_path
  end

  def destroy
    @alarm = Alarm.find(params[:id])
    @alarm.destroy
    redirect_to alarms_path
  end

  private

  def alarm_params
    params.require(:alarm).permit(:kaiju, :location, :to, :from, :body, :status)
  end
end
