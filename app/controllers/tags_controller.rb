class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
    @entry = Entry.find(params[:entry_id])
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @tag = @entry.tags.new
    @tag = Tag.new(tag_params)
    @tag.entry = @entry
    if @tag.save
      redirect_to entry_path(@entry)
    else
      render "entries/show"
    end
  end


  def destroy
    @entry = Entry.find(params[:entry_id])
    @tag.destroy
    redirect_to entry_path(@entry)
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

end
