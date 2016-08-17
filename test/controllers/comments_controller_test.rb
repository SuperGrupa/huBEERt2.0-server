require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
    @user = users(:janusz)
  end

  test "should get index" do
    get pub_comments_url(@comment.pub_id)
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post pub_comments_url(@comment.pub_id), params: authorizing_params(@user).merge(
        comment: {
          pub_id: @comment.pub_id, rating: @comment.rating, text: @comment.text, user_id: @comment.user_id
        }
      )
    end

    assert_response 201
  end
end
