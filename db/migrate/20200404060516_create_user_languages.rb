class CreateUserLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_languages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
      t.integer :mastery, default: 0

      t.timestamps
    end
  end
end
