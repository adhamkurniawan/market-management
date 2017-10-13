class Product < ApplicationRecord
  include Paperclip::Glue
  belongs_to :user
  belongs_to :category

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.svg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, :description, :category_id, presence: true
  validates :description, length: { maximum: 200 }
end
