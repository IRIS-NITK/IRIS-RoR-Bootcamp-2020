require_relative 'fizz_buzz'
require 'minitest/autorun'

class FizzBuzzTest < Minitest::Test
  def test_fizz_buzz_with_default_x_y
    test_cases = [
      {
        n: 5,
        result: ['1', '2', 'Fizz', '4', 'Buzz']
      },
      {
        n: 15,
        result: [
          '1', '2', 'Fizz', '4', 'Buzz', 'Fizz', '7', '8', 'Fizz',
          'Buzz', '11', 'Fizz', '13', '14', 'FizzBuzz'
        ]
      },
      {
        n: 16,
        result: [
          '1', '2', 'Fizz', '4', 'Buzz', 'Fizz', '7', '8', 'Fizz',
          'Buzz', '11', 'Fizz', '13', '14', 'FizzBuzz', '16'
        ]
      },
      {
        n: 0,
        result: []
      }
    ]

    test_cases.each do |test_case|
      assert_equal test_case[:result], fizz_buzz(n: test_case[:n]), "fizz_buzz(n: #{test_case[:n]}) is #{test_case[:result]}"
    end
  end

  def test_fizz_buzz_with_custom_x_y
    test_cases = [
      {
        n: 5,
        x: 3,
        y: 3,
        result: ['1', '2', 'FizzBuzz', '4', '5']
      },
      {
        n: 6,
        x: 2,
        y: 3,
        result: ['1', 'Fizz', 'Buzz', 'Fizz', '5', 'FizzBuzz']
      },
      {
        n: 6,
        x: 3,
        y: 2,
        result: ['1', 'Buzz', 'Fizz', 'Buzz', '5', 'FizzBuzz']
      },
    ]

    test_cases.each do |test_case|
      assert_equal test_case[:result], fizz_buzz(n: test_case[:n], x: test_case[:x], y: test_case[:y]),
        "fizz_buzz(n: #{test_case[:n]}, x: #{test_case[:x]}, y: #{test_case[:y]}) is #{test_case[:result]}"
    end
  end

  def test_fizz_buzz_raises_argument_error
    assert_raises(ArgumentError) do
      fizz_buzz(n: -1)
    end

    assert_raises(ArgumentError) do
      fizz_buzz(n: 5, x: 0)
    end

    assert_raises(ArgumentError) do
      fizz_buzz(n: 5, y: 0)
    end
  end
end
