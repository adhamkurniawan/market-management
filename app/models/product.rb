class Product < ApplicationRecord
  include Paperclip::Glue
  belongs_to :user
  belongs_to :category

  acts_as_votable

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.svg",
                    :storage => :cloudinary, :path => 'market-management/products/:filename',
                    :cloudinary_credentials => Rails.root.join("config/cloudinary.yml")
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :name, :description, :category_id, presence: true
  validates :description, length: { maximum: 600 }
end
