class TagsLoja < ActiveRecord::Migration
  def up
    add_column :lojas, :tags, :string
  end

  def down
  end
end
