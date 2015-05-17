class AddStatusToExams < ActiveRecord::Migration
  def change
    add_column :exams, :status, :string, default: :Start
  end
end
