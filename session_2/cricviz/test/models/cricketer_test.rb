require "test_helper"

class CricketerTest < ActiveSupport::TestCase
  test "has self.import_classical_batters" do
    names = [
      'Brian Lara', 'Kumar Sangakkara', 'Rahul Dravid', 'Ricky Ponting',
      'Sachin Tendulkar'
    ]

    Cricketer.import_classical_batters

    assert_equal names, Cricketer.where(name: names).order(name: :asc).pluck(:name)
  end

  test "has batting_strike_rate" do
    assert_in_delta 600, Cricketer.new(runs_scored: 6, balls_faced: 1).batting_strike_rate, 0.01
    assert_in_delta 250, Cricketer.new(runs_scored: 250, balls_faced: 100).batting_strike_rate, 0.01
  end

  test "batting_strike_rate is nil when data is incomplete" do
    assert_nil Cricketer.new(runs_scored: 100, balls_faced: nil).batting_strike_rate
    assert_nil Cricketer.new(runs_scored: nil, balls_faced: 100).batting_strike_rate
    assert_nil Cricketer.new(balls_faced: 0).batting_strike_rate
  end

  test "has batting_average" do
    assert_in_delta 36.18, Cricketer.new(innings_batted: 73, runs_scored: 1954, not_out: 19).batting_average, 0.01
    assert_in_delta 92, Cricketer.new(innings_batted: 4, runs_scored: 92, not_out: 3).batting_average, 0.01
    assert_in_delta 92, Cricketer.new(innings_batted: 4, runs_scored: 92, not_out: 4).batting_average, 0.01
  end

  test "batting_average is nil when data is incomplete" do
    assert_nil Cricketer.new(innings_batted: nil, runs_scored: 100, not_out: 10).batting_average
    assert_nil Cricketer.new(innings_batted: 10, runs_scored: nil, not_out: 10).batting_average
    assert_nil Cricketer.new(innings_batted: 10, runs_scored: 100, not_out: nil).batting_average
  end

  test "has australian_players" do
    names = [
      'Cameron Green', 'David Warner', 'Mitchell Starc', 'Nathan Lyon',
      'Pat Cummins', 'Steve Smith'
    ]

    assert_equal names, Cricketer.australian_players.order(name: :asc).pluck(:name)
  end

  test "has batters" do
    names = [
      'Ajinkya Rahane', 'David Warner', 'Hanuma Vihari', 'Rohit Sharma',
      'Steve Smith'
    ]

    assert_equal names, Cricketer.batters.order(name: :asc).pluck(:name)
  end

  test "has bowlers" do
    names = [
      'Jasprit Bumrah', 'Mitchell Starc', 'Mohammed Amir', 'Nathan Lyon',
      'Pat Cummins', 'Ravichandran Ashwin'
    ]

    assert_equal names, Cricketer.bowlers.order(name: :asc).pluck(:name)
  end

  test "has descending_by_matches" do
    names = [
      'Nathan Lyon', 'Ajinkya Rahane', 'Mitchell Starc',
      'Ravindra Jadeja', 'Pat Cummins', 'Cameron Green'
    ]

    assert_equal names, Cricketer.where(name: names.shuffle).descending_by_matches.pluck(:name)
  end

  test "has self.update_innings" do
    batting_scorecard = [
      ['David Warner', true, 5, 8, 0, 0],
      ['Steve Smith', true, 131, 226, 16, 0],
      ['Cameron Green', false, 84, 132, 8, 4]
    ]

    bowling_scorecard = [
      ['Jasprit Bumrah', 150, 7, 66, 2],
      ['Ravichandran Ashwin', 144, 1, 74, 0],
      ['Ravindra Jadeja', 108, 3, 62, 4]
    ]

    Cricketer.update_innings(batting_scorecard, bowling_scorecard)

    # TODO: Weak Tests
    bumrah = cricketers(:jasprit_bumrah)
    assert_equal 25, bumrah.innings_bowled
    assert_equal 3787, bumrah.balls_bowled
    assert_equal 1706, bumrah.runs_given
    assert_equal 79, bumrah.wickets_taken

    green = cricketers(:cameron_green)
    assert_equal 5, green.innings_batted
    assert_equal 152, green.runs_scored
    assert_equal 1, green.not_out
    assert_equal 84, green.high_score
    assert_equal 383, green.balls_faced
    assert_equal 1, green.half_centuries
    assert_equal 4, green.sixes_scored
    assert_equal 14, green.fours_scored
  end

  test "self.update_innings raises ActiveRecord::RecordNotFound when no players are found" do
    batting_scorecard = [
      ['David Warner', true, 5, 8, 0, 0],
      ['Steve Smith', true, 131, 226, 16, 0],
      ['Cameron Green', false, 84, 132, 8, 4]
    ]

    bowling_scorecard = [
      ['T Natarajan', 150, 7, 66, 2],
      ['Ravichandran Ashwin', 144, 1, 74],
      ['Ravindra Jadeja', 108, 3, 62, 4]
    ]

    exception = assert_raises(ActiveRecord::RecordNotFound) do
      Cricketer.update_innings(batting_scorecard, bowling_scorecard)
    end

    assert_equal 'T Natarajan', exception.message
  end


  test "has self.ban" do
    name = 'Mohammed Amir'

    Cricketer.ban(name)

    assert_empty Cricketer.where(name: name)
  end

  test "self.ban raises ActiveRecord::RecordNotFound when no players are found" do
    name = 'Shane Warne'

    assert_raises(ActiveRecord::RecordNotFound) do
      Cricketer.ban(name)
    end
  end
end
