class AddMarkdownToNote < ActiveRecord::Migration
  def up
    add_column :notes, :markdown, :boolean
  end

  def down
    remove_column :notes, :markdown
  end
end
