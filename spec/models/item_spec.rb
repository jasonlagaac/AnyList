require 'spec_helper'

describe Item do
  before(:each) do
    @event = Factory(:event)
    @attr = { 
              :name => "blah",
              :description => "blah"
            }
  end
  
  it "should create an instance given valid attributes" do
    @event.items.create!(@attr)
  end
  
  describe "event associations" do
    before(:each) do
      @item = @event.items.create(@attr)
    end
    
    it "should have a event attribute" do
      @item.should respond_to(:event)
    end
    
    it "should have the right associated event" do
      @item.event_id.should == @event.id
      @item.event.should == @event
    end
  end
  
  describe "validations" do
    it "should require an event id" do
      Item.new(@attr).should_not be_valid
    end
    
    it "should require a nonblank name" do
      @event.items.build(@attr.merge(:name => " ")).should_not be_valid
    end
    
    it "should reject a long name" do
      @event.items.build(@attr.merge(:name => "a" * 9000)).should_not be_valid
    end
       
    it "should require a nonblank description" do
      @event.items.build(@attr.merge(:description => " ")).should_not be_valid
    end   
    
    it "should reject a long description" do
      @event.items.build(@attr.merge(:description => "a" * 9000)).should_not be_valid
    end
  end
end
