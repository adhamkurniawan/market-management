class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  before_create :set_default_role

  has_many :categories, dependent: :destroy
  has_many :products, dependent: :destroy

  validates_presence_of :name, :email, :password, :password_confirmation

  private
    def set_default_role
      self.role ||= Role.find_by_name('user')
    end
end
