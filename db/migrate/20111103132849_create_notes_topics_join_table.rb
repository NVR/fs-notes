class CreateNotesTopicsJoinTable < ActiveRecord::Migration
  def up
    create_table :notes_topics, :id => false do |t|
      t.integer :note_id
      t.integer :topic_id
    end
  end

  def down
    drop_table :notes_topics
  end
end
