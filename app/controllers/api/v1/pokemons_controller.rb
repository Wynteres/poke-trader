class Api::V1::PokemonsController < ApplicationController
  def list
    render json: Pokemon::ListPokemonsPaginated.new(list_params).fetch_list
  end

  def show; end

  def search; end

  private

  def list_params
    { page_index: params[:page].presence || 1 }
  end
end
