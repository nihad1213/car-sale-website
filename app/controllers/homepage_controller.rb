class HomepageController < ApplicationController
  PER_PAGE = 12

  def index
    scope = Vehicle.filter_by(params).sorted_by(params[:sort])

    @total       = scope.count
    @page        = [ params[:page].to_i, 1 ].max
    @total_pages = [ (@total / PER_PAGE.to_f).ceil, 1 ].max
    @vehicles    = scope.includes(:place).with_attached_pics
                        .offset((@page - 1) * PER_PAGE).limit(PER_PAGE)

    @favorite_ids = current_user ? current_user.favorites.pluck(:vehicle_id) : []

    @blogs = Blog.with_attached_title_img.with_rich_text_description.latest.limit(3)
  end
end
