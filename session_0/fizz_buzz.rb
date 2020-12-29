# Fizz Buzz is a word game for children to teach them about division.
#
# We will use it to learn about transforming traditional C-like for
# loops into ruby code and a bit of error handling.
#
# The rules of the game are as follows:
# - The first player says the number "1".
# - Each subsequent player counts upwards in turn.
# - Numbers divisible by 3 are replaced by the word "Fizz"
# - Numbers divisible by 5 are replaced by the word "Buzz"
# - Numbers divisible by both 3 and 5 are replaced by the word "FizzBuzz"
#
# For example, a round of Fizz Buzz would go as follows:
#
# 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14,
# FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz,
# 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz, ...
#
# We will take a look at generalization of Fizz Buzz - instead of
# numbers divisible by 3 or 5, we will let the user decide.
# They are denoted by keyword arguments (see README.md for reference)
# `x` and `y`.
#
# The first keyword argument `n` represents the number of turns.
#
# We will be returning an array of strings, containing what each player
# says on their turn.
#
# For example, fizz_buzz(n: 6, x: 2, y: 3) should return the following:
# ["1", "Fizz", "Buzz", "Fizz", "5", "FizzBuzz"]
#
# What happens if the function is called by x (or y) = 0 or negative? 
#
# The divisiblity by zero is not defined and neither do the little
# children know how to divide by negative numbers.
#
# We will raise an `ArgumentError` exception to let the caller know that
# their function arguments were incorrect.
def fizz_buzz(n:, x: 3, y: 5)
  raise NotImplementedError # TODO
end
