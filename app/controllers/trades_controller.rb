class TradesController < ApplicationController
  def index
    @trades = Trade.all
  end

  def new; end

  def create; end
end
