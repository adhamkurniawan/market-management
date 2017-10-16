class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # belongs_to :role
  # before_create :set_default_role
  has_many :categories, dependent: :destroy
  has_many :products, dependent: :destroy

  include Paperclip::Glue

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "150x150#" },
                    :storage => :cloudinary, :path => 'market-management/avatars/:filename',
                    :cloudinary_credentials => Rails.root.join("config/cloudinary.yml")
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :name, :email, :avatar, presence: true

  # private
  #   def set_default_role
  #     self.role ||= Role.find_by_name('user')
  #   end
end
