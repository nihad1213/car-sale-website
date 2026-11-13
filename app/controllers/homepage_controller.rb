class HomepageController < ApplicationController
  def index
    @blogs = Blog.with_attached_title_img.with_rich_text_description.latest.limit(3)
  end
end
