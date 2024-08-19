class AddFrameworkToVideo < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :framework, :integer, default: 0
  end
end
