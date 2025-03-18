class CoffeeShopsController < ApplicationController
  include CoffeeShopsHelper
  include ErrorsHelper

  def closest_coffee_shops
    permitted = params.expect(:latitude, :longitude)
    @coffee_shops = sort_coffee_shops_by_distance(params[:latitude], params[:longitude])
    render json: @coffee_shops, status: :ok
  end
end
