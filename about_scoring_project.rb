require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

TRIPLET_MULTIPLIER = 100
ONES_TRIPLET_MULTIPLIER = 1000
ONE_VALUE = 100
FIVE_VALUE = 50

def score(dice)
  result = 0
  return result if invalid_dice?(dice)
  
  dice_sort = {1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0}
  
  #Fill our hash array with +1 for each result of the die face.
  dice.each do |die|
    dice_sort[die] += 1
  end
  
  dice_sort.each_pair do |key, value|
    if non_single_score?(key)
      result += key * TRIPLET_MULTIPLIER if value >= 3
    else
      groups_of_three, remainder = value/3, value%3
      
      result += (ONES_TRIPLET_MULTIPLIER * groups_of_three) + (ONE_VALUE * remainder) if key == 1
      result += (key * TRIPLET_MULTIPLIER * groups_of_three) + (FIVE_VALUE * remainder ) if key == 5
    end
  end
  
  result
end

def non_single_score?(die)
  return true if die != 1 && die != 5
end

def invalid_dice?(dice)
  return true if dice.length == 0
end

class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
