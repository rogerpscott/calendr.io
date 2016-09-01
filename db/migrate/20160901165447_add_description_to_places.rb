class AddDescriptionToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :description, :text
  end
end
