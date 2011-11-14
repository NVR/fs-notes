require 'spec_helper'

describe User do

  before(:each) do
    @user = User.new
  end

  it "should have feed" do
    @user.feed.should eq(Note.where("user_id = ?", @user.id))
    @user.feed.should be
  end
end
