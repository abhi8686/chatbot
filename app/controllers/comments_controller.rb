class CommentsController < ApplicationController
  before_action :set_status

  def new
  end

  def create
    respond_to do |format|
      @comment = @status.comments.new(comment_params)
      @comment.user = current_user
      @path = status_path(@status)
      @statuses = @status.user.statuses.all
   
    if @comment.save
      format.html { redirect_to statuses_url, notice: 'Comment was successfully created.' }
      format.js 
    else
        format.html {redirect_to statuses_url}
        format.js
    end
      format.js
    end
  end

  private

  def set_status
    @status = Status.find(params[:status_id])
  end


    def comment_params
      params.require(:comment).permit(:body)
    end
end
