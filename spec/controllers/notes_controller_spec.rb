require 'spec_helper'

describe NotesController do
  login_user
  render_views
  before (:all) do
    @preview = false
    Topic.create(:name => 'Opal')
  end

  before(:each) do
    @test_note = Note.create(:id => '1', :title => 'Some title', :body => 'Some body', :user_id => '1')
    @test_note_2 = Note.create(:id => '2', :title => 'Some title', :body => 'Some body', :user_id => '2')
  end

  describe "GET 'new'" do
    it "should have title" do
      get 'new'
      response.should have_selector("title", :content => "New note")
    end
  end

  describe "GET 'index'" do
    it "should be success" do
      get 'index'
      response.should be_success
    end

    it "should work with topics" do
      get 'index', topic_id: '1'
      response.should be_success
    end

    it "should have search function" do
      get 'index', topic_id: '1', search: "foobar"
      response.should be_success
    end

    it "should redirect to last page,then page-number exceed" do
      get 'index', page: '1000'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should have title" do
      get 'edit', id: @test_note.to_param
      response.should have_selector("title", :content => "Edit note")
    end

    it "should not allow to edit other users' notes" do
      get 'edit', id: @test_note_2.to_param
      response.should_not be_success
    end
  end

  describe "GET 'destroy'" do
    it "should delete note" do
      delete 'destroy', id: @test_note.to_param
      response.should redirect_to notes_path
    end
  end

  describe "GET 'update'" do
    it "should update note" do
      put 'update', id: @test_note.to_param, note: @test_note.attributes
      response.should redirect_to note_path(assigns(:note))
    end

    it "should allow preview" do
      put 'update', id: @test_note.to_param, commit: 'Preview'
      response.should be_success
    end

    it "should allow return to edit form" do
      put 'update', id: @test_note.to_param, note: @test_note.attributes, commit: 'Back'
      response.should be_success
    end

    it "should not save updates,if they are having errors" do
      @test_note.title = nil
      put 'update',id: @test_note.to_param, note: @test_note.attributes, commit: 'Update'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should create note with params" do
      post 'create', note: @test_note.attributes
      response.should redirect_to note_path(assigns(:note))
    end

    it "should allow preview" do
      post 'create', note: @test_note.attributes, commit: 'Preview'
      response.should be_success
    end

    it "should allow return to edit form" do
      post 'create', note: @test_note.attributes, commit: 'Back'
      response.should be_success
    end

    it "should not save note,if it is having errors" do
      @test_note.title = nil
      post 'create', note: @test_note.attributes, commit: 'Create Note'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be success" do
      get 'show', id: @test_note.to_param
      response.should be_success
    end
  end
end
