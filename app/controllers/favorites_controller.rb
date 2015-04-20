class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorited_entries = current_user.favorited_entries
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @favorite = current_user.favorites.new
    @favorite.entry = @entry
    respond_to do |format|
      if @favorite.save
      format.html {redirect_to @entry, notice: "Favorited!"}
      format.js {render}
    else
      format.html {redirect_to @entry, notice:
        "Unable to favorite, have you already favorited this entry?"}
      format.js {render}
    end
  end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @entry = @favorite.entry
    @favorite.destroy
    respond_to do |format|
      format.html {redirect_to @entry, notice: "Unfavorited!"}
      format.js {render}
    end
  end

end
