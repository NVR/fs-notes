require 'spec_helper'

describe TopicsController do
  describe "rescue_action" do
    it "should redirect to topic_note_path" do
      get 'show' , id: '1'
      response.should redirect_to topic_notes_path('1')
    end
  end
end
