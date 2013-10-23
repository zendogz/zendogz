class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :city
      t.string :postal
      t.string :phone_home
      t.string :phone_cell
      t.string :phone_work
      t.integer :authority
      t.date :born_on

      t.timestamps
    end
  end
end

