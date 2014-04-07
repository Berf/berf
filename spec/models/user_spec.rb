require 'spec_helper'

describe User do
  
  describe "#add_contact" do
    it 'accepts a name and a phone number for the contact' do
      user = User.create
      contact = user.add_contact(:nick_name => "", :first_name => "Avi", :last_name => "Flombaum", :phone_number => "9175336666", :birthday => "1984/1/29", :email => "a@somthing.com")
      
      contact.save
      user.save
      # expect(user.contacts.find_by(:phone_number => '9175336666').first_name).to eq("Avi")
      expect(contact.first_name).to eq("Avi")
      expect(contact.phone_number).to eq("9175336666")
    end

    it 'associates the contact to the user' do
      user = User.create
      user.add_contact(:nick_name => "", :first_name => "Avi", :last_name => "Flombaum", :phone_number => "9175336666", :birthday => "1984/1/29", :email => "a@somthing.com")
      user.save
      expect(Contact.find_by(:phone_number => "9175336666").user).to eq(user)
    end
  end
end
