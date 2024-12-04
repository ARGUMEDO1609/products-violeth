class ProductSize < ApplicationRecord
  belongs_to :product
  belongs_to :size
  has_many_attached :images
  belongs_to :category, optional: true
end
