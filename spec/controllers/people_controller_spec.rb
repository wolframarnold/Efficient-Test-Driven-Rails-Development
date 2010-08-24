require 'spec_helper'

describe PeopleController do
  include Devise::TestHelpers

  context "when not signed in" do

    it 'should redirect to login' do
      get :index
      response.should redirect_to("http://test.host/users/sign_in?unauthenticated=true")
    end

    it 'should not call the action method' do
      controller.should_not_receive(:random_action_that_shouldnt_be_called)
      get :random_action_that_shouldnt_be_called
    end

  end

  context "when signed in" do
    before do
      @user = User.create(:email => "joe@example.com", :password => "password")
      sign_in @user
      @person = Factory(:person)
    end

    describe "GET 'index'" do
      before do
        get 'index'
      end

      it 'should load all people' do
        assigns[:people].should == [@person]
      end

    end

    describe "GET 'show'" do
      before do
        get 'show', :id => @person.id
      end

      it 'should load that person' do
        assigns[:person].should == @person
      end
    end

    describe "GET 'new'" do
      before do
        get 'new'
      end

      it 'should assign a new Person object' do
        assigns[:person].should_not be_nil
        assigns[:person].should be_kind_of(Person)
        assigns[:person].should be_new_record
      end

      it 'should have a blank address object' do
        assigns[:person].addresses.should_not be_empty
        assigns[:person].addresses.length.should == 1  # Note: don't use count here, because that will do a database lookup
        # The record created in the controller is an in-memory object only and length will return the in-memory count + database count
      end
    end

    describe "GET 'edit'" do

      it 'should load that person' do
        get 'edit', :id => @person.id
        assigns[:person].should == @person
      end

      it 'should build a blank address if the person does not have an address yet' do
        @person.addresses.should be_empty
        get 'edit', :id => @person.id
        assigns[:person].addresses.should_not be_empty
      end

      it 'should does not build a blank address if the person already has an address' do
        Factory(:address, :person => @person)
        @person.addresses.count be_empty
        lambda {
          get 'edit', :id => @person.id
        }.should_not change(@person.addresses, :count)
      end
    end

    describe "POST 'create'" do
      context "when successful" do
        before do
          @post_params = {:first_name => "Jona", :last_name => "Jones"}
        end
        it 'redirects to index' do
          post :create, :person => @post_params
          response.should redirect_to(people_path)
        end
        it 'assigns the person' do
          post :create, :person => @post_params
          assigns[:person].should_not be_nil
          assigns[:person].should be_kind_of(Person)
        end
        it 'creates a record' do
          lambda {
            post :create, :person => @post_params
          }.should change(Person, :count).by(1)
        end

        context "with nested addresses" do
          before do
            @post_params = {:first_name => "Jona", :last_name => "Jones",
                            :addresses_attributes => [ {:city   => "San Francisco",
                                                        :street => "123 Main St",
                                                        :zip    => "94103",
                                                        :state  => "CA" }] }
          end
          it 'creates both a person and an address' do
            lambda {
            lambda {
              post :create, :person => @post_params
            }.should change(Person, :count).by(1)
            }.should change(Address, :count).by(1)
          end
        end

      end

      context "when failing" do
        before do
          @post_params = {:first_name => "", :last_name => "Jones"}
        end
        it 're-renders "new"' do
          post :create, :person => @post_params
          response.should render_template('new')
        end
        it 'assigns the person' do
          # This is important, so that when re-rendering "new", the previously entered values are already set
          post :create, :person => @post_params
          assigns[:person].should_not be_nil
          assigns[:person].should be_kind_of(Person)
        end
        it 'does NOT create a record' do
          lambda {
            post :create, :person => @post_params
          }.should_not change(Person, :count)
        end
      end
      context "when using a verb other than POST" do
        it 'rejects the request' do
          controller.should_not_receive(:create)
          get :create
        end
      end

    end

    describe "PUT 'update'" do
      context "when successful" do
        before do
          @person = Factory(:person, :first_name => "Jona")
        end
        it 'redirects to index' do
          put :update, :id => @person.to_param
          response.should redirect_to(people_path)
        end
        it 'assigns the person' do
          put :update, :id => @person.to_param
          assigns[:person].should == @person
        end
        it 'updates the record' do
          lambda {
            put :update, :id => @person.to_param, :person => {:first_name => "Johanna"}
          }.should change {@person.reload.first_name}.from("Jona").to("Johanna")
        end

        context "with nested addresses" do
          before do
            @address = Factory(:address, :street => "123 Main St")
            @person  = @address.person
          end
          it 'updates a nested address' do
            lambda {
              put :update, :id => @person.to_param, :person => {:addresses_attributes =>
                                                                 [{:id => @address.to_param,:street => "345 3rd St"}]}
            }.should change{@address.reload.street}.from("123 Main St").to("345 3rd St")
          end
        end

      end

      context "when failing" do
        before do
          @person = Factory(:person, :first_name => "Jona")
        end
        it 're-renders "edit"' do
          put :update, :id => @person.to_param, :person => {:first_name => ""}
          response.should render_template('edit')
        end
        it 'assigns the person' do
          # This is important, so that when re-rendering "new", the previously entered values are already set
          put :update, :id => @person.to_param, :person => {:first_name => "Johanna"}
          assigns[:person].should == @person
        end
        it 'does NOT update the record' do
          lambda {
            put :update, :id => @person.to_param, :person => {:first_name => ""}
          }.should_not change{@person.reload.first_name}
        end
      end
      context "when using a verb other than PUT" do
        it 'rejects the request' do
          controller.should_not_receive(:update)
          get :update
        end
      end

    end
  end

end
