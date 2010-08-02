class PeopleController < ApplicationController

  before_filter :load_person, :only => [:show, :edit]
  verify :method => :post, :only => :create

  def index
    @people = Person.all
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_to people_path
    else
      render :new
    end
  end

  private

  def load_person
    @person = Person.find(params[:id])
  end

end
