class Api::V1::TradesController < ApplicationController
  def validate
    render json: { valid: true }
  end
end
