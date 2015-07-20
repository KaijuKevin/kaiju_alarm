require 'rails_helper'

describe Alarm, :vcr => true do
  it "doesn't save the alarm if twilio gives an error" do
    alarm = Alarm.new(:body => 'hi', :to => '1111111', :from => '5032785042', :kaiju => "Godzilla", :location => "Portland")
    expect(alarm.save).to eq(false)
  end

  it 'adds an error if the to number is invalid' do
    alarm = Alarm.new(:body => 'hi', :to => '1111111', :from => '5032785042', :kaiju => "Godzilla", :location => "Portland")
    alarm.save
    expect(alarm.errors.messages[:base]).to eq "The 'To' number 1111111 is not a valid phone number."
  end

  it 'creates an alarm' do
    alarm = Alarm.new(:body => 'hi', :to => '1111111', :from => '5032785042', :kaiju => "Godzilla", :location => "Portland")
    alarm.save
    expect(alarm.kaiju).to eq("Godzilla")
  end

  it 'checks that the default value for "active" on an alarm is true' do
    alarm = Alarm.new(:body => 'hi', :to => '1111111', :from => '5032785042', :kaiju => "Godzilla", :location => "Portland")
    alarm.save
    expect(alarm.active).to eq(true)
  end

  it 'checks that an alarm can be deactivated' do
    alarm = Alarm.new(:body => 'hi', :to => '1111111', :from => '5032785042', :kaiju => "Godzilla", :location => "Portland")
    alarm.save
    alarm.update(:active => false)
    alarm.save
    expect(alarm.active).to eq(false)
  end

end
