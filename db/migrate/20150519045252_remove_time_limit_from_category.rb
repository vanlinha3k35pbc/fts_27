class RemoveTimeLimitFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :time_limit
  end
end
