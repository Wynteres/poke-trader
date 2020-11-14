class Api::V1::PokemonsController < ApplicationController
  def list
    render json: ListPokemonsPaginated.new(list_params).fetch_list
  end

  def show; end

  def search; end

  private

  def list_params
    page = params[:page].present? ? params[:page].to_i : 1
    { page_index: page }
  end
end
