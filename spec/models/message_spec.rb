require 'spec_helper'

describe Message do

  context "Validations" do
    %w(sender recipient).each do |attr|
      it "requires #{attr}" do
        m = Message.new
        m.should_not be_valid
        m.errors.on(attr).should_not be_nil
      end
    end
  end

  context "Associations" do
    it 'belongs to a sender' do
      Message.new.should respond_to(:sender)
    end

    it 'can retrieve sender and is a person object' do
      msg = Factory(:message)
      msg.sender.should_not be_nil
      msg.sender.should be_kind_of(Person)
    end

    it 'belongs to a recipient' do
      Message.new.should respond_to(:recipient)
    end

    it 'can retrieve recipient and is a person object' do
      msg = Factory(:message)
      msg.recipient.should_not be_nil
      msg.recipient.should be_kind_of(Person)
    end

    it 'can retrieve new messages' do
      recipient = Factory(:person)
      msg_new = Factory(:message, :recipient => recipient)
      msg_read = Factory(:read_message, :recipient => recipient)

      # Verify data set is non-trivial and correct
      recipient.messages.should == [msg_new,msg_read]

      recipient.unread_messages.should == [msg_new]
    end
  end

end
