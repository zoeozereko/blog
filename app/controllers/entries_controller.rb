class EntriesController < ApplicationController
  #before_action :find_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :find_entry, only: [:edit, :update, :destroy]


  def index
    if params[:search]
      @entries = Entry.search(params['search']).paginate(:page => 1, :per_page => 6)
    else
      @entries = Entry.all.most_recent.paginate(:page => params[:page], :per_page => 6)
    end
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)
    @entry.tags << tag_split
    if @entry.save
      redirect_to entries_path
    else
      render :new
    end
  end

  def show
    @entry = Entry.find(params[:id])
    @comment = Comment.new
    @tag = Tag.new
    @favorite = @entry.favorite_for(current_user) if user_signed_in?
  end

  def edit
    @entry = current_user.entries.find(params[:id])
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
    @entry = current_user.entries.find(params[:id])
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

  def find_entry
    @entry = current_user.entries.find(params[:id])
    redirect_to root_path, alert: "Access denied." unless can? :manage, @entry
  end

  def find_post
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :body, :tag_string, :image, {tag_ids: []})
  end

end
