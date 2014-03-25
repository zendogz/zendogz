class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :person, index: true
      t.references :course, index: true
      t.references :status, index: true

      t.timestamps
    end
  end
end
