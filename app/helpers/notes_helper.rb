module NotesHelper
  def can_edit?(note)
    user_signed_in? && (current_user.id == note.user_id)
  end
end
