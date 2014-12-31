module ApplicationHelper

  private

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html.html_safe
  end

  def search_path(topic_id = nil, user_id = nil)
    if topic_id
      topic_notes_path(topic_id)
    else
      user_id.present? ? user_notes_path(user_id) : notes_path
    end
  end


end
