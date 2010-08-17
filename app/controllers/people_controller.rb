class PeopleController < ApplicationController

  before_filter :load_person, :only => [:show, :edit]
  verify :method => :post, :only => :create
  verify :method => :put,  :only => :update

  def index
    @people = Person.all
  end

  def show
  end

  def new
    @person = Person.new
    @person.addresses.build
  end

  def edit
    @person.addresses.build if @person.addresses.empty?
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_to people_path
    else
      render :new
    end
  end

  def update
    @person = Person.find(params[:id])
    @person.attributes = params[:person]
    if @person.save
      redirect_to(people_path)
    else
      render :edit
    end
  end

  private

  def load_person
    @person = Person.find(params[:id])
  end

end
