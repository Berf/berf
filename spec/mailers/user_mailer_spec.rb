require "spec_helper"

describe UserMailer do

  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = User.create
    @contact = @user.add_contact(:nick_name => "Avi", :first_name => "Avi", :last_name => "Flombaum", :phone_number => "9175336666", :birthday => "1984/1/29", :email => "a@somthing.com")
    @user.email = 'test@test.com'
    @user.save
    UserMailer.sms_sent_notification(@user, @contact).deliver
  end

  after(:each) do
  ActionMailer::Base.deliveries.clear
end

  it 'should send an email' do
    ActionMailer::Base.deliveries.count.should == 1
  end

  it 'renders the receiver email' do  
    ActionMailer::Base.deliveries.first.to.should == ['test@test.com']
  end

  it 'should set the subject to the correct subject' do
    ActionMailer::Base.deliveries.first.subject.should == 'You just wished Avi a happy birthday!'
  end

  it 'renders the sender email' do  
    ActionMailer::Base.deliveries.first.from.should == ['berf12345@gmail.com']
  end


end
