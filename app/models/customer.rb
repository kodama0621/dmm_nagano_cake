class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shippings, dependent: :destroy
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/}

  has_many :cart_items
  has_many :orders

  def active_for_authentication?
    super && (self.is_deleted == false) end

  def full_name
    return self.last_name + ' ' + self.first_name
  end
end
