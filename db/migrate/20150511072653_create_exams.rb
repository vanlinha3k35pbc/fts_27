class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :result
      t.datetime :started_time
      t.references :user, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :exams, :users
    add_foreign_key :exams, :categories
  end
end
