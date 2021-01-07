# The function `lower_case` takes an array of strings and converts
# any non-lower case alphabet (A..Z) to corresponding lower case
# alphabet
def lower_case(words)
  # Equivalent to words.map { |word| word.downcase }
  words.map(&:downcase)
end

# Similar to `lower_case`, this function modifies the array in-place
# and does not return any value.
def lower_case!(words)
  # the '!' symbol, implies inplace operation
  # it is equivalent to words = words.map(&:downcase) 
  words.map!(&:downcase)
end

# Given a prefix and an array of words, return an array containing
# words that have same prefix.
#
# For example:
# words_with_prefix('apple', ['apple', 'ball', 'applesauce']) would
# return the words 'apple' and 'applesauce'.
def words_with_prefix(prefix, words)
  # the select method filters a collection, keeping values that
  # evaluate to true.
  words.select { |word| word.start_with?(prefix) }
end

# The similarity score between two words is defined as the length of
# largest common prefix between the words.
#
# For example:
# - Similarity of (bike, bite) is 2 as 'bi' is the largest common prefix.
# - Similarity of (apple, bite) is 0 as there are no common letters in
#   the prefix
# - similarity of (applesauce, apple) is 5 as 'apple' is the largest
#   common prefix.
# 
# The function `similarity_score` takes two words and returns the
# similarity score (an integer).
def similarity_score(word_1, word_2)
  smaller_len = word_1.size < word_2.size ? word_1.size : word_2.size

  # Find the first index where the words are different.
  # If there is no such index, return the smaller length.
  (0...smaller_len).find { |i| word_1[i] != word_2[i] } || smaller_len
end

# Given a chosen word and an array of words, return an array of word(s)
# with the maximum similarity score in the order they appear.
def most_similar_words(chosen_word, words)
  max_score = 0
  similar_words = []

  words.each do |word|
    # score of current word
    score = similarity_score(chosen_word, word)

    # if the score of current word > max_score
    # update the max score and add word to answers array
    if score > max_score
      max_score = score
      similar_words = [word]
    # If a word has the same score as established max score append it to the answers list
    elsif score == max_score
      similar_words.append(word)
    end
  end

  # return the answer using rubys implicit return feature
  similar_words
end
