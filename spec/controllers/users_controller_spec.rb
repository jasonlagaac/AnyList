require 'spec_helper'

describe UsersController do
  render_views 
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign Up")
    end
  end
  
  describe "GET 'show'" do
    before (:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should show the user's events" do
      event1 = Factory(:event, :user => @user, :title => "Foo Bar")
      event2 = Factory(:event, :user => @user, :title => "Bar Bin")
      get :show, :id => @user
      response.should have_content("Foo Bar")
      response.should have_content("Bar Bin")
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { 
          :firstname => "", 
          :lastname => "",
          :username => "", 
          :email => "",
          :password => "",
          :password_confirmation => ""
        }
      end
    
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign Up")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = {  
          :username => "darth_vader",
          :email => "darth.vader@sithlord.com",
          :password => "aaaaaa",
          :password_confirmation => "aaaaaa"
        }
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end
  end
  
  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title"  do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit User")
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    describe "failure" do
      before(:each) do
        @attr = { :email => "", :username => "", 
                  :password => "", :password_confirmation => ""
                }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit User")
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = { :username => "obiwan", :email => "ben.kenobi@jedi.org",
                  :password => "aaaaaa", :password_confirmation => "aaaaaa"
                }
      end
      
      it "should change the user's attribues" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.username == @attr[:username]
        @user.email.should == @attr[:email]
      end
      
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/i
      end
    end
  end
  
  describe "authentication of edit/update pages" do
    before(:each) do
      @user = Factory(:user)
    end
      
    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end
        
      it "should deny access to 'update" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
  end
end
