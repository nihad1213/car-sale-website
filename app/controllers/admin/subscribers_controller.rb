class Admin::SubscribersController < ApplicationController
  def show
  end

  def create
    @subscriber = new Subscriber()
  end

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
