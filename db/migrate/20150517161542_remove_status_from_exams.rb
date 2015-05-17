class RemoveStatusFromExams < ActiveRecord::Migration
  def change
    remove_column :exams, :status
  end
end
