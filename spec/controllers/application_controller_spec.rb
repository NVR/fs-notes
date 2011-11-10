require 'spec_helper'

describe ApplicationController do
  describe '#existing_topics' do
    it "should show all topics" do
      existing_topics.should eq(Topic.all)
    end
  end
end
