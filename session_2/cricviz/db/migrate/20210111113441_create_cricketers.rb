class CreateCricketers < ActiveRecord::Migration[6.1]
  def change
    create_table :cricketers do |t|
      t.string :name
      t.string :country

      t.string :role
      t.integer :matches

      t.integer :innings_batted, default: 0
      t.integer :runs_scored, default: 0
      t.integer :not_out, default: 0
      t.integer :high_score, default: 0
      t.integer :balls_faced, default: 0
      t.integer :centuries, default: 0
      t.integer :half_centuries, default: 0
      t.integer :sixes_scored, default: 0
      t.integer :fours_scored, default: 0

      t.integer :innings_bowled, default: 0
      t.integer :balls_bowled, default: 0
      t.integer :runs_given, default: 0
      t.integer :wickets_taken, default: 0
      t.string :best_bowling_innings, default: '-'
      t.string :best_bowling_match, default: '-'

      t.integer :catches, default: 0
      t.integer :stumpings, default: 0

      t.timestamps
    end
  end
end
