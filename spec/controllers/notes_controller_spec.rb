require 'spec_helper'

describe NotesController do
  login_user
  render_views
  @test_note = Note.create(:id => '1', :title => 'Some title', :body => 'Some body')
  describe "GET 'new'" do
    it "should have title" do
      get 'new'
      response.should have_selector("title", :content => "New note")
    end
  end

  describe "GET 'edit'" do
    it "should have title" do
      get '@test_note.id/edit'
      response.should have_selector("title", :content => "Edit note")
    end
  end

end
