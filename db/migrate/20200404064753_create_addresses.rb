class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :profile, null: true, foreign_key: true
      t.references :jam, null: true, foreign_key: true
      t.string :given_address
      t.string :street
      t.string :postal_code
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
