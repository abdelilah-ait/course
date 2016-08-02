
class User < ApplicationRecord
  
  validates :email, :password, presence: :true
  validates :email, uniqueness: :true
  # validates :password, confirmation: :true
  has_secure_password
  has_many :phones, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates_confirmation_of :password

  def as_jason(option={})
  	{name: self.name, email: self.email}
  end
  	# def as_json(options={})
   #      super(only: [:name, :email])
   #  end
  
	
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
