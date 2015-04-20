class EntriesController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @entries = Entry.all.most_recent
    if params[:search]
      @entries = Entry.search(params[:search]).order("created_at DESC")
    else
      @entries = Entry.all.order('created_at DESC')
    end
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.tags << tag_split
    if @entry.save
      redirect_to entries_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @tag = Tag.new
    @favorite = @entry.favorite_for(current_user) if user_signed_in?
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to entries_path(@entry)
    else
      flash[:alert] = "Please correct the errors below."
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_path, notice: "Entry has been deleted."
  end

  def tag_split
    tags = []
    split = entry_params[:tag_string].split(",")
    split.each do |tag_name|
      tag = Tag.new(name: tag_name)
      tag.save
      tags << tag
    end
    tags
  end

  private
  def find_post
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :body, :tag_string, :image, {tag_ids: []})
  end

end
