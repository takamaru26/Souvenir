class Admin::GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update]
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを登録しました。"
    else
      flash.now[:danger] = "予期せぬエラーが発生しました"
      @genres = Genre.all
      render 'index'
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルを更新しました。"
    else
      flash.now[:danger] = "予期せぬエラーが発生しました"
      render "edit"
    end
  end
  
  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
