class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :last_name
      t.date :birth_date
      t.text :bio
      t.boolean :privacy, default: false

      t.timestamps
    end
  end
end
