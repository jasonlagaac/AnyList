require 'spec_helper'

describe EventsController do
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :title => "" }
      end
      
      it "should not create a event" do
        lambda do
          post :create, :event => @attr
        end.should_not change(Event, :count)
      end
      
      it "should render the main page" do
        post :create, :event => @attr
        response.should render_template('pages/main')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = { :title => "Lorem ipsum" }
      end
      
      it "should create an event" do
        lambda do
          post :create, :event => @attr
        end.should change(Event, :count).by(1)
      end
      
      it "should redirect to the main page" do
        post :create, :event => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash message" do
        post :create, :event => @attr
        flash[:success].should =~ /event created/i
      end
    end
  end
end
