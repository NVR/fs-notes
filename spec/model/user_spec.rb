require 'spec_helper'

describe User do

  before(:each) do
    @user = User.new
  end

  it "should show feed" do
    Note.where("user_id = ?", @user.id)
  end

  it "should find feed" do
    Note.where("user_id = ?", @user.id).should_not be_nil
  end

  it "should be feed" do
    @user.feed.should eq(Note.where("user_id = ?", @user.id))
  end

end
