# This will stop the Rubocop
class TennisGame1
  POINT_VALUES = %w(Love Fifteen Thirty Forty).freeze

  ADVANTAGE = 'Advantage '.freeze
  WINNER    = 'Win for '.freeze
  DEUCE     = 'Deuce'.freeze
  ALL       = '-All'.freeze

  def initialize(player1_name, player2_name)
    @players = [
      { name: player1_name, points: 0 },
      { name: player2_name, points: 0 }
    ]
    @player1 = @players[0]
    @player2 = @players[1]
  end

  def find_player_by_name(name)
    @players.detect do |player|
      player[:name] == name
    end
  end

  def award_point(name)
    player = find_player_by_name(name)
    player[:points] += 1
  end

  def equal_points?
    @player1[:points] == @player2[:points]
  end

  def in_advantage?
    @player1[:points] >= 4 || @player2[:points] >= 4
  end

  def determine_score
    if equal_points?
      all_or_deuce
    elsif in_advantage?
      compare_advantage
    else
      award_score
    end
  end

  def score(points)
    POINT_VALUES[points]
  end

  def all_or_deuce
    current_score = score @player1[:points]

    if @player1[:points] < 3
      current_score + ALL
    else
      DEUCE
    end
  end

  def compare_advantage
    point_difference = @player1[:points] - @player2[:points]

    if point_difference.abs == 1
      determine_advantage(point_difference)
    else
      pick_winner(point_difference)
    end
  end

  def award_advantage(name)
    ADVANTAGE + name
  end

  def determine_advantage(point_difference)
    if point_difference > 0
      award_advantage @player1[:name]
    else
      award_advantage @player2[:name]
    end
  end

  def pick_winner(point_difference)
    if point_difference >= 2
      WINNER + @player1[:name]
    else
      WINNER + @player2[:name]
    end
  end

  def award_score
    score_one = score(@player1[:points])
    score_two = score(@player2[:points])

    "#{score_one}-#{score_two}"
  end
end
