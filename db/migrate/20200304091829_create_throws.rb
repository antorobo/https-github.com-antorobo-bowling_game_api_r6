class CreateThrows < ActiveRecord::Migration[6.0]
  def change
    create_table :throws do |t|
      t.integer :throwId, default: 0
      t.integer :pins, default: 0
      t.integer :frameId, default: 1
      t.integer :frame_score, default: 0
      t.integer :special_calls, default: 0
      t.integer :bonus1, default: 0
      t.integer :bonus2, default: 0
      t.integer :frame_complete, default: 0
      t.integer :game_complete, default: 0
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
