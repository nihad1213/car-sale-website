class Admin::SiteConfigurationsController < ApplicationController
  before_action :require_admin!
  before_action :set_site_configuration

  def show
    redirect_to edit_admin_site_configuration_path
  end

  def edit
  end

  def update
    if @site_configuration.update(site_configuration_params)
      redirect_to edit_admin_site_configuration_path, notice: "Site configuration was successfully updated."
    else
      flash.now[:alert] = "Please fix the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_site_configuration
    @site_configuration = SiteConfiguration.first_or_create!
  end

  def site_configuration_params
    params.require(:site_configuration).permit(
      :site_name, :tagline,
      :listings_count, :dealers_count, :satisfaction_rate,
      :phone_number, :email, :address,
      :meta_title, :meta_description, :meta_keywords, :canonical_url, :robots,
      :og_title, :og_description, :og_image_url, :og_type,
      :twitter_card, :twitter_site,
      :google_analytics_id, :google_site_verification
    )
  end
end
