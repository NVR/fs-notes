require 'spec_helper'

describe Topic do

  it "should have method to show all topics" do
    Topic.all.should eq(Topic.find(:all))
  end

end
