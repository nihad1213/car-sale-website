class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      redirect_back fallback_location: root_path,
                    notice: "Thank you for subscribing!"
    else
      redirect_back fallback_location: root_path,
                    alert: @subscriber.errors.full_messages.to_sentence
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
