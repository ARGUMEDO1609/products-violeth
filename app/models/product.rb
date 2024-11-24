class Product < ApplicationRecord
  has_many :product_sizes
  has_many :sizes, through: :product_sizes

  has_rich_text :description
  has_many_attached :images

  ["XS", "S", "M", "L", "XL"].each do |size|
    Size.find_or_create_by(name: size)
  end
end
