class Item < ApplicationRecord
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  belongs_to :vendor

  validates :name, presence: true, uniqueness: true, on: :create
  validates :name, presence: true, on: :update
  validates :description, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  #validates :tags, presence: true

  before_save :set_image

  enum status: [:active, :retired]

  def to_money
    price / 100
  end

  def set_image
    if self[:image].empty?
      self[:image] = "http://img.providr.com/n-SALT-628x314.jpg"
    end
  end

  def self.by_popularity
    select('items.*, count(order_items.id) as order_items_count')
    .joins(:order_items)
    .group(:id)
    .order('order_items_count DESC')
  end

  def price_for_item_at_order
    order_items
    .first
    .item_price_record / 100
  end

  def price_at_sale
    order_items.first.item_price_record / 100
  end

  def quantity_sold(order_id)
    order_items.where(order_id: order_id).count
  end
end
