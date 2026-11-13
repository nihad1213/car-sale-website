class Admin::BlogsController < ApplicationController
  before_action :require_admin!
  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @blogs = Blog.with_attached_title_img.includes(:creator).latest
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.creator = current_user
    @blog.updater = current_user

    if @blog.save
      redirect_to admin_blog_path(@blog), notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @blog.updater = current_user

    if @blog.update(blog_params)
      redirect_to admin_blog_path(@blog), notice: "Blog was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to admin_blogs_path, notice: "Blog was successfully deleted."
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:header, :title_img, :description)
  end
end
