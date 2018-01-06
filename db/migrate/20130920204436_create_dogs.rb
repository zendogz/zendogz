class CreateDogs < ActiveRecord::Migration[5.1]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :colour
      t.date :born_on
      t.references :person, index: true

      t.timestamps
    end
  end
end
