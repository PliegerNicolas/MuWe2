class CreateUserMusicStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_music_styles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :music_style, null: false, foreign_key: true

      t.timestamps
    end
  end
end
