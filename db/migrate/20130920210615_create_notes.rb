class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.references :dog, index: true
      t.text :note

      t.timestamps
    end
  end
end
