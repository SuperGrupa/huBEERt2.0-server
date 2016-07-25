require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "should get index" do
    get pub_comments_url(@comment.pub_id)
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post pub_comments_url(@comment.pub_id), params: {
        comment: {
          pub_id: @comment.pub_id, rating: @comment.rating, text: @comment.text, user_id: @comment.user_id
        }
      }
    end

    assert_response 201
  end

  test "should show comment" do
    get pub_comment_url(@comment.pub_id, @comment)
    assert_response :success
  end

  test "should update comment" do
    patch pub_comment_url(@comment.pub_id, @comment), params: {
      comment: {
        pub_id: @comment.pub_id, rating: @comment.rating, text: @comment.text
      }
    }
    assert_response 200
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete pub_comment_url(@comment.pub_id, @comment)
    end

    assert_response 204
  end
end
