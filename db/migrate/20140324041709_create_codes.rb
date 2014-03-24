class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.references :set, index: true
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
