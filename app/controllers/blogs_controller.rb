class BlogsController < ApplicationController
  def index
    @blogs = Blog.with_attached_title_img.with_rich_text_description.latest
  end

  def show
    @blog = Blog.with_attached_title_img.with_rich_text_description.find(params[:id])
    @related_blogs = Blog.with_attached_title_img.with_rich_text_description
                         .where.not(id: @blog.id).latest.limit(3)
  end
end
