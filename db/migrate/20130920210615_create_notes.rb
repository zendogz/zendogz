class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :dog
      t.text :note

      t.timestamps
    end
  end
end
