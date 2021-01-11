require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test 'has a string column name' do
    assert_equal :string, Student.type_for_attribute('name').type
  end

  test 'has a string column roll_number' do
    assert_equal :string, Student.type_for_attribute('roll_number').type
  end

  test 'has a string column branch' do
    assert_equal :string, Student.type_for_attribute('branch').type
  end

  test 'has a decimal column cgpa' do
    assert_equal :decimal, Student.type_for_attribute('cgpa').type
  end

  test 'stores cgpa to two decimal points' do
    assert_equal 2, Student.type_for_attribute('cgpa').scale
  end

  test 'has a string column address' do
    assert_equal :text, Student.type_for_attribute('address').type
  end

  test 'has a integer column admission_year' do
    assert_equal :integer, Student.type_for_attribute('admission_year').type
  end
end
