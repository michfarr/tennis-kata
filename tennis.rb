# tennis.rb
class TennisGame1
  Player = Struct.new(:name, :points)

  WINNER    = 'Win for '.freeze
  ADVANTAGE = 'Advantage '.freeze
  DEUCE     = 'Deuce'.freeze
  ALL       = '-All'.freeze

  POINT_VALUES = %w(Love Fifteen Thirty Forty).freeze

  def initialize(player1_name, player2_name)
    @players = [
      Player.new(player1_name, 0),
      Player.new(player2_name, 0)
    ]
  end

  def player1
    @players[0]
  end

  def player2
    @players[1]
  end

  def find_by_name(name)
    @players.find { |player| player.name == name }
  end

  def award_point(name)
    player = find_by_name(name)
    player.points += 1
  end

  def determine_score
    return all_or_deuce      if equal_points?
    return compare_advantage if in_advantage?
    award_score
  end

  def score(points)
    POINT_VALUES[points]
  end

  def equal_points?
    player1.points == player2.points
  end

  def all_or_deuce
    current_score = score player1.points

    return DEUCE if deuce?
    current_score + ALL
  end

  def deuce?
    player1.points > 2
  end

  def in_advantage?
    player1.points > 3 || player2.points > 3
  end

  def compare_advantage
    return determine_winner if game_over?
    determine_advantage
  end

  def game_over?
    point_difference.abs > 1
  end

  def point_difference
    player1.points - player2.points
  end

  def determine_advantage
    return award_advantage(player1.name) if point_difference.positive?
    award_advantage(player2.name)
  end

  def award_advantage(name)
    ADVANTAGE + name
  end

  def award_score
    score_one = score(player1.points)
    score_two = score(player2.points)

    "#{score_one}-#{score_two}"
  end

  def determine_winner
    return WINNER + player1.name if point_difference >= 2
    WINNER + player2.name
  end
end
