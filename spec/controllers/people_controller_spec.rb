require 'spec_helper'

describe PeopleController do

  before do
    @person = Factory(:person)
  end

  describe "GET 'index'" do
    before do
      get 'index'
    end

    xit "should be successful" do
      response.should be_success
    end

    xit 'should render index template' do
      response.should render_template('index')
    end

    it 'should load all people' do
      assigns[:people].should == [@person]
    end

  end

  describe "GET 'show'" do
    before do
      get 'show', :id => @person.id
    end

    xit "should be successful" do
      response.should be_success
    end

    xit "should render 'show' template" do
      response.should render_template('show')
    end

    it 'should load that person' do
      assigns[:person].should == @person
    end
  end

  describe "GET 'new'" do
    before do
      get 'new'
    end

    xit "should be successful" do
      response.should be_success
    end

    xit "should render 'new' template" do
      response.should render_template('new')
    end

    it 'should assign a new Person object' do
      assigns[:person].should_not be_nil
      assigns[:person].should be_kind_of(Person)
      assigns[:person].should be_new_record
    end
  end

  describe "GET 'edit'" do
    before do
      get 'edit', :id => @person.id
    end

    xit "should be successful" do
      response.should be_success
    end

    xit "should render 'edit' template" do
      response.should render_template('edit')
    end

    it 'should load that person' do
      assigns[:person].should == @person
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
end
