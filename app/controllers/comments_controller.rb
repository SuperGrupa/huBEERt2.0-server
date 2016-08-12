class CommentsController < ApplicationController
  before_action :set_pub, only: :index
  before_action :authenticate_by_token, only: :create

  # GET /comments
  def index
    @comments = Comment.where(pub_id: @pub.id).includes(:user)

    render json: @comments.map { |c| c.general_info }
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: pub_comments_url(@comment.pub_id, @comment)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

    def set_pub
      @pub = Pub.find(params[:pub_id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:pub_id, :user_id, :text, :rating)
    end
end
