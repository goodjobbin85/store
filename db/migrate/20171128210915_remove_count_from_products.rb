class RemoveCountFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :count, :integer
  end
end
