# frozen_string_literal: true

class TradesController < ApplicationController
  def index
    @trades = Trade.all
  end

  def create
    @trade = CreateTradeFromJson.new(create_trade_params).create

    if @trade.valid?
      flash[:success] = 'Sua pokeTroca registrada!'
      redirect_to root_path
    else
      flash[:danger] = 'Er... Equipe rocket? Verifique sua troca, algo está errado!'
      render 'trades/new'
    end
  end

  private

  def create_trade_params
    params.require(:trade)
          .permit!
          .slice(:sent_package_pokemons, :received_package_pokemons)
          .to_h
          .symbolize_keys
  end
end
