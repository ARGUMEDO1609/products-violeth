class ChangeAvailableSizesToArrayInProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :available_sizes, :text, array: true, default: []
  end
end
