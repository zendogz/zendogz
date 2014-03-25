class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :dog, index: true
      t.text :note

      t.timestamps
    end
  end
end
