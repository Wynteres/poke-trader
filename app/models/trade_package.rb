class TradePackage < ApplicationRecord
  belongs_to :trade
  has_many :pokemon
end
