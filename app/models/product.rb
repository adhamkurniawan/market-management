class Product < ApplicationRecord
  include Paperclip::Glue
  belongs_to :user
  belongs_to :category

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.svg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def count_product_by_category
    Product.where(category_id: @category.id).count
  end
end
