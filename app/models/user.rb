
class User < ApplicationRecord
  validates :email, uniqueness: :true
	has_secure_password
	def admin?
		self.role == "admin"
	end
end
