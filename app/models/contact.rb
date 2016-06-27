class Contact < ActiveRecord::Base
  belongs_to :user

  def self.birthdays_today
    # postgres version: 
    where("extract(day FROM birthday) = ? AND extract(month FROM birthday) = ?", Date.today.strftime('%d'), Date.today.strftime('%m'))
    # sqlite 3 version:
    # where("strftime('%d', birthday) = ? AND strftime('%m', birthday) = ?", Date.today.strftime('%d'), Date.today.strftime('%m'))
  end

  def formatted_birthday
    if !birthday.nil?
      "Birthday: #{birthday.month}/#{birthday.day}/#{birthday.year}"
    else
      "Enter friend's birthday!"
    end
  end

  def send_message(message)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new account_sid, auth_token

    # from = <add your twillio number>

    client.account.messages.create(
      :from => from,
      :to => self.phone_number,
      :body => message
    )
    #TODO "Sent message to #{name}"
  end
end
  
