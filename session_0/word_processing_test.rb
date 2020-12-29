require_relative 'word_processing'
require 'minitest/autorun'

class WordProcessingTest < Minitest::Test
  def test_lower_case
    assert_equal ['', 'hello', 'world', 'nice'], lower_case(['', 'HELLO', 'WoRlD', 'nice'])
  end

  def test_lower_case!
    words = ['', 'HELLO', 'WoRlD', 'nice']
    lower_case!(words)

    assert_equal ['', 'hello', 'world', 'nice'], words
  end

  def test_words_with_prefix
    prefix = 'apple'
    words = ['apple', 'ball', 'applesauce', 'app']

    assert_equal ['apple', 'applesauce'], words_with_prefix(prefix, words)

    prefix = ''
    words = ['apple', 'ball', 'applesauce', 'app']

    assert_equal words, words_with_prefix(prefix, words)
  end

  def test_similarity_score
    assert_equal 2, similarity_score('bite', 'bike')
    assert_equal 0, similarity_score('apple', 'bite')
    assert_equal 5, similarity_score('applesauce', 'apple')
    assert_equal 5, similarity_score('apple', 'applesauce')
    assert_equal 0, similarity_score('', 'apple')
  end

  def test_most_similar_words
    chosen_word = 'apple'
    words = ['ball', 'applesauce', 'bike']
    similar_words = most_similar_words(chosen_word, words)
    assert_equal ['applesauce'], similar_words

    chosen_word = 'apple'
    words = ['ball', 'applesauce', 'bike', 'apple']
    similar_words = most_similar_words(chosen_word, words)

    assert_equal ['applesauce', 'apple'], similar_words
  end
end
