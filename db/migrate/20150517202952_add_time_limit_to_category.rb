class AddTimeLimitToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :time_limit, :integer
  end
end
