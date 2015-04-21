class CommentsController < ApplicationController
  before_action :authenticate_user!


  def index
    @comments = Comment.all
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @comment = current_user.comments.new(comment_params)
    @comment.entry = @entry

    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_entry_owner(@comment).deliver_later
        format.html {redirect_to entry_path(@entry)}
        format.js {render :create_success}
      else
        format.html {render "entries/show"}
        format.js {render :create_failure}
      end
    end
  end

  def edit
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {redirect_to comments_path(@comment)}
        format.js {render :update_success}
      else
        format.html {render :edit}
        format.js {render :update_failure}
      end
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def destroy
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.find(params[:id])
    head :unautherized and return unless can? :destroy, @comment
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to entry_path(@entry), notice: "Entry deleted"}
      format.js {render}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
