class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.references :person, index: true
      t.references :course, index: true
      t.references :status, index: true
      t.date :enrolled_on

      t.timestamps
    end
  end
end
