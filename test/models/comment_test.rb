require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:one)
  end

  test "it's not valid without specifing attributes" do
    assert_not Comment.new.valid?
  end

  test "text must be present and up to 160 characters" do
    @comment.text = ""
    assert_not @comment.valid?

    @comment.text = "a"*161
    assert_not @comment.valid?
  end

  test "rating must be integer from range 1..5" do
    @comment.rating = 2.5
    assert_not @comment.valid?

    @comment.rating = 0
    assert_not @comment.valid?

    @comment.rating = 6
    assert_not @comment.valid?
  end

  test "comment from fixture should be valid" do
    assert @comment.valid?
  end
end
