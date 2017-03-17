class TennisGame1
  POINT_VALUES = %w(Love Fifteen Thirty Forty).freeze

  def initialize(player1_name, player2_name)
    @player1 = {
      name: player1_name,
      points: 0
    }

    @player2 = {
      name: player2_name,
      points: 0
    }
  end

  def award_point(name)
    if name == @player1[:name]
      @player1[:points] += 1
    else
      @player2[:points] += 1
    end
  end

  def determine_score
    if @player1[:points] == @player2[:points]
      scores_are_equal(@player1[:points])
    elsif @player1[:points] >= 4 || @player2[:points] >= 4
      point_difference = @player1[:points] - @player2[:points]
      compare_advantage(point_difference)
    else
      award_score
    end
  end

  def give_score(points)
    POINT_VALUES.at(points)
  end

  def scores_are_equal(points)
    score_name = give_score points

    if points < 3
      "#{score_name}-All"
    else
      'Deuce'
    end
  end

  def compare_advantage(point_difference)
    if point_difference == 1
      "Advantage #{@player1[:name]}"
    elsif point_difference == -1
      "Advantage #{@player2[:name]}"
    elsif point_difference >= 2
      "Win for #{@player1[:name]}"
    else
      "Win for #{@player2[:name]}"
    end
  end

  def award_score
    score_one = give_score(@player1[:points])
    score_two = give_score(@player2[:points])

    "#{score_one}-#{score_two}"
  end
end
