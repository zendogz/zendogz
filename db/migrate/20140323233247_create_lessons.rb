class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :description
      t.string :handout
      t.datetime :lesson_at
      t.references :course
      t.references :status

      t.timestamps
    end
  end
end
