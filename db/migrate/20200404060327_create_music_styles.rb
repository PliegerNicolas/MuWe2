class CreateMusicStyles < ActiveRecord::Migration[6.0]
  def change
    create_table :music_styles do |t|
      t.string :music_style

      t.timestamps
    end
  end
end
