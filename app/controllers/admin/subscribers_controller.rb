class Admin::SubscribersController < ApplicationController
  before_action :require_admin!

  def index
    @subscribers = Subscriber.order(created_at: :desc)
  end
end
