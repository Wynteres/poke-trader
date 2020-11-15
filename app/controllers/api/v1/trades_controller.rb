class Api::V1::TradesController < ApplicationController
  def validate
    trade = BuildTradeFromJson.new(validate_trade_params).build

    render json: { valid: trade.valid? }
  end

  private

  def validate_trade_params
    trade_json = params.require(:trade)

    JSON.parse(trade_json)
        .symbolize_keys
        .slice(:sent_package_pokemons, :received_package_pokemons)
        .to_h
  end
end
