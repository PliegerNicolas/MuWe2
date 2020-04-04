class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :jam, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
