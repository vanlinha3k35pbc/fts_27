class CreateAnswersheets < ActiveRecord::Migration
  def change
    create_table :answersheets do |t|
      t.references :exam, index: true
      t.references :question, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
    add_foreign_key :answersheets, :exams
    add_foreign_key :answersheets, :questions
    add_foreign_key :answersheets, :answers
  end
end
