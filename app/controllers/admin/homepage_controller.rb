class Admin::HomepageController < ApplicationController
  before_action :require_admin!
end
