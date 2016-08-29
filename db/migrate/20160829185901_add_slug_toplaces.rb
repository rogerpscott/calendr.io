class AddSlugToplaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :slug, :string, unique: true
    add_index :places, :slug
  end
end
