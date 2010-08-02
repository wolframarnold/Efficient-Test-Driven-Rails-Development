require 'spec_helper'

describe PeopleController do

  it 'routes GET /people to people, index' do
    {:get => '/people'}.should route_to(:controller=> 'people', :action => 'index')
  end

  it 'routes GET /people/new to people, new' do
    {:get => '/people/new'}.should route_to(:controller=> 'people', :action => 'new')
  end

  it 'routes GET /people/15 to people, show' do
    {:get => '/people/15'}.should route_to(:controller=> 'people', :action => 'show', :id => '15')
  end

  it 'routes GET /people/15/edit to people, edit' do
    {:get => '/people/15/edit'}.should route_to(:controller=> 'people', :action => 'edit', :id => '15')
  end

  it 'routes POST /people to people, create' do
    {:post => '/people'}.should route_to(:controller=> 'people', :action => 'create')
  end
end
