class LocationsController < ApplicationController
  def find_address
    response = { address: Geocoder.address(
 											[params[:latitude], params[:longitude]])}
 	  render json: response.to_json
  end
end
