
class User < ApplicationRecord
  validates :email, :password, presence: :true
  validates :email, uniqueness: :true
  # validates :password, confirmation: :true
  has_secure_password
  validates_confirmation_of :password
  
	has_many :phones
	def admin?
		self.role == "admin"
	end

	def info
		[email, password].join " ----> "
	end

	def self.by_letter(letter)
		where("name LIKE ?", "%#{letter}%").order(:name)
	end
end
