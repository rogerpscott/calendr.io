class AddDaysToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :monday, :boolean, default: true
    add_column :places, :tuesday, :boolean, default: true
    add_column :places, :wednesday, :boolean, default: true
    add_column :places, :thursday, :boolean, default: true
    add_column :places, :friday, :boolean, default: true
    add_column :places, :saturday, :boolean, default: true
    add_column :places, :sunday, :boolean, default: true
  end
end
