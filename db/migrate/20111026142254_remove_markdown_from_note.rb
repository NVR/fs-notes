class RemoveMarkdownFromNote < ActiveRecord::Migration
  def up
    remove_column :notes, :markdown
  end

  def down
    add_column :notes, :markdown, :boolean
  end
end
