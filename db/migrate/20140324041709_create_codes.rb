class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.references :set, index: true
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
