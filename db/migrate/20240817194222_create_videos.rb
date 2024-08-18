class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :titulo
      t.string :canal
      t.string :youtube_id
      t.integer :desejo
      t.boolean :assistido, default: false

      t.timestamps
    end
  end
end
