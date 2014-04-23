class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
  
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    
    access_token = request.env["omniauth.auth"]["credentials"]["token"]

    # Create contacts based on logged_in user using google contact API
    request = Typhoeus::Request.new(
     "https://www.google.com/m8/feeds/contacts/default/full?max-results=200",
      headers: { Authorization: "Bearer #{access_token}" }
    )
    response = request.run
    
    json = Hash.from_xml(response.body).to_json
    contacts = JSON.parse(json).map { |contact| contact }
      
    gmail_contact = contacts[0][1]["entry"]
    
    #TODO import birthday, profile picture url
    gmail_contact.each do |entry|
      if entry["title"] != nil # filter automatically added in your google contacts
        if entry["email"].is_a? Array # friends who have more than two email accounts
          if !@user.contacts.find_by(:email => entry["email"].first["address"])
              user = @user.contacts.new do |u|
                u.first_name = entry["title"].split(' ').first
                u.last_name = entry["title"].split(' ').last
                u.nick_name = entry["title"].split(' ').first
                u.email = entry["email"].first["address"]
              end

              if entry["phoneNumber"].is_a? Array
                user.phone_number = entry["phoneNumber"].first
              else
                user.phone_number = entry["phoneNumber"]
              end

              user.save
          end
        else
          if entry["email"] && !@user.contacts.find_by(:email => entry["email"]["address"])
              user = @user.contacts.new do |u|
                u.first_name = entry["title"].split(' ').first
                u.last_name = entry["title"].split(' ').last
                u.nick_name = entry["title"].split(' ').first
                u.email = entry["email"]["address"]
              end

              if entry["phoneNumber"].is_a? Array
                user.phone_number = entry["phoneNumber"].first
              else
                user.phone_number = entry["phoneNumber"]
              end

              user.save
          end
        end  
      end
    end

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication 

    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end

