class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :categories
  end
end
