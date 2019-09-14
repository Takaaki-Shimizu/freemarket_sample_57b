class Product < ApplicationRecord
  has_many   :images, dependent: :destroy

  belongs_to :address
  belongs_to :user
  belongs_to :category
  validates :name, :postage_id, :price, :description, :shipping_date_id, presence: true
end
