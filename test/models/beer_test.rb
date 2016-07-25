require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  def setup
    @beer = beers(:pils)
  end

  test "it's not valid without specifing attributes" do
    assert_not Beer.new.valid?
  end

  test "name must be present and up to 30 characters" do
    @beer.name = ""
    assert_not @beer.valid?

    @beer.name = "a"*31
    assert_not @beer.valid?
  end

  test "description must be up to 300 characters" do
    @beer.description = "a"*301
    assert_not @beer.valid?
  end

  test "alcohol must be present, decimal and greater than or equal to 0.0" do
    @beer.alcohol = nil
    assert_not @beer.valid?

    @beer.alcohol = "abc"
    assert_not @beer.valid?

    @beer.alcohol = -1.0
    assert_not @beer.valid?

    @beer.alcohol = 4.55
    assert_not @beer.valid?

    @beer.alcohol = 4.5
    assert @beer.valid?
  end

  test "extract must be decimal and greater than 0.0" do
    @beer.extract = "abc"
    assert_not @beer.valid?

    @beer.extract = -1.0
    assert_not @beer.valid?

    @beer.extract = 12.0
    assert @beer.valid?
  end

  test "volume must be present, decimal and greater than 0.0" do
    @beer.volume = nil
    assert_not @beer.valid?

    @beer.volume = "abc"
    assert_not @beer.valid?

    @beer.volume = -1.0
    assert_not @beer.valid?

    @beer.volume = 0.5
    assert @beer.valid?
  end

  test "sample beer from fixtures should be valid" do
    assert @beer.valid?
  end
end
