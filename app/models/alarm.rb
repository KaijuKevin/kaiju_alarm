class Alarm < ActiveRecord::Base

  def sound_alarm
    begin
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      response = @client.account.messages.create({
        :from => from,
        :to => to,
        :body => body
      })
    rescue Twilio::REST::RequestError => e
      e.message
      errors.messages[:base] = e.message
      false
    end
  end
end
