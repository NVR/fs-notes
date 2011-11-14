require 'spec_helper'

describe Note do
  let(:some_note){ Note.new }
 
  it "should be invalid without title" do
    some_note.title = nil
    some_note.should_not be_valid
    some_note.errors[:title].should_not be_nil
  end

  it "should be invalid without body" do
    some_note.body = nil
    some_note.should_not be_valid
    some_note.errors[:body].should_not be_nil
  end

  it "should be invalid without author" do
    some_note.user_id = nil
    some_note.should_not be_valid
    some_note.errors[:user_id].should_not be_nil
  end

end
