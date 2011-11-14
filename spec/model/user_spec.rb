require 'spec_helper'

describe User do
  let(:user) { User.new }

  it "should have connection to notes" do
    user.feed.should eq(Note.where("user_id = ?", user.id))
    user.feed.should be
  end
end
