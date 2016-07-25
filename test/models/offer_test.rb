require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  def setup
    @offer = offers(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not Offer.new.valid?
  end

  test "value must be present, with 2 decimal places and greater than 0.0" do
    @offer.value = nil
    assert_not @offer.valid?

    @offer.value = "abc"
    assert_not @offer.valid?

    @offer.value = -1.23
    assert_not @offer.valid?

    @offer.value = 0.00
    assert_not @offer.valid?

    @offer.value = 1.2
    assert_not @offer.valid?

    @offer.value = 1.234
    assert_not @offer.valid?
  end

  test "offer from fixture should be valid" do
    assert @offer.valid?
  end
end
