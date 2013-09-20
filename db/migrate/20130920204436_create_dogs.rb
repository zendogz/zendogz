class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :colour
      t.date :born_on
      t.references :person

      t.timestamps
    end
  end
end
