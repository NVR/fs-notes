require 'spec_helper'

describe Note do

  before(:each) do
    @note = Note.new
  end

  it "should be invalid without title" do
    @note.title = nil
    @note.should_not be_valid
    @note.errors[:title].should_not be_nil
  end

  it "should be invalid without body" do
    @note.body = nil
    @note.should_not be_valid
    @note.errors[:body].should_not be_nil
  end

  it "should be invalid without author" do
    @note.user_id = nil
    @note.should_not be_valid
    @note.errors[:user_id].should_not be_nil
  end

  it "should have page count" do
    Note.pages_count == Note.count/(Note::PER_PAGE + 1)
  end

end
