require 'test_helper'

class CityTest < ActiveSupport::TestCase
  def setup
    @city = cities(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not City.new.valid?
  end

  test "name must be present and up to 30 characters" do
    @city.name = ""
    assert_not @city.valid?

    @city.name = "a"*31
    assert_not @city.valid?
  end

  test "city from fixture should be valid" do
    assert @city.valid?
  end
end
