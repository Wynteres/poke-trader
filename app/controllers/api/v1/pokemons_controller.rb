# frozen_string_literal: true

module Api
  module V1
    class PokemonsController < ApplicationController
      def list
        @pokemon_list = ListPokemonsPaginated.new(list_params).fetch_list
      rescue StandardError
        head 500
      end

      private

      def list_params
        page = params[:page].present? ? params[:page].to_i : 1
        { page_index: page }
      end
    end
  end
end
