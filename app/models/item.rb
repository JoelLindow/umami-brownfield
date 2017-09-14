class Item < ApplicationRecord
  has_many :item_tags
  has_many :tags, through: :item_tags

  def to_money
    "$#{Money.new(price, "USD")}"
  end

end