require 'spec_helper'

describe Contact do
  
  describe ".birthdays_today" do

    it 'find all contacts whose birthday is today' do
      birthday = Time.local(2014, 4, 3)
      person_whose_birthday_is_today = Contact.create(:birthday => '1984/4/3')

      expect(Contact.birthdays_today).to include(person_whose_birthday_is_today)
    end 

  end


  # describe "" do
  #   it 'send default birthday message' do
  #     user = User.create
  #     contact = Contact.create(:birthday => '2014/4/1', :user_id => user.id)


  #   end

  #   it ''
  # end 
end

# Find all contacts whose birthday is today
#   and for each of those contacts
#     send them a birthday message on behalf of the User





 # describe "#add_contact" do
 #    it 'accepts a name and a phone number for the contact' do
 #      user = User.create
 #      user.add_contact("Avi Flombaum", 91775336666, "01/29/1984")

 #      expect(Contact.find_by_phone_number(91775336666).name).to eq("Avi Flombaum")
 #    end

 #    it 'associates the contact to the user' do
 #      user = User.create
 #      user.add_contact("Avi Flombaum", 91775336666, "01/29/1984")

 #      expect(Contact.find_by_phone_number(91775336666).user).to eq(user)
 #     end
 #    end