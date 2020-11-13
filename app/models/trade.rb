class Trade < ApplicationRecord
  has_one :sent_package, class_name: 'TradePackage'
  has_one :received_package, class_name: 'TradePackage'
end
