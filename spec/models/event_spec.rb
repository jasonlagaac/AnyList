require 'spec_helper'

describe Event do
  before(:each) do
    @user = Factory(:user)
    @attr = { :title => "Christmas" }
  end
  
  it "should create a instance given valid attributes" do
    @user.events.create!(@attr)
  end
  
  describe "user associations" do
    before(:each) do
      @event = @user.events.create(@attr)
    end
    
    it "should have a user attribute" do
      @event.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @event.user_id.should == @user.id
      @event.user.should == @user
    end
  end
  
  describe "validations" do
    it "should require a user id" do
      Event.new(@attr).should_not be_valid
    end
    
    it "should require a nonblank title" do
      @user.events.build(:title => " ").should_not be_valid
    end
    
    it "should reject long content" do
      @user.events.build(:title => "a" * 141).should_not be_valid
    end
  end
  
  describe "item associations" do
    before(:each) do
      @event = @user.events.create(:title => "An Event")
      @item1 = Factory(:item, :event => @event, :created_at => 1.day.ago)
      @item2 = Factory(:item, :event => @event, :created_at => 1.hour.ago)
    end
    
    it "should have an items attribute" do
      @event.should respond_to(:items)
    end
    
    it "should destroy associated items" do
      @event.destroy
      [@item1, @item2].each do |item|
        Item.find_by_id(item.id).should be_nil
      end
    end
    
  end
end
