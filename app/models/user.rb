class User < ApplicationRecord
  has_many :courses
  ROLES = ['admin', 'lecturer']
  
  def admin?
    role == 'admin'
  end

  def lecturer?
    role == 'lecturer'
  end
  # validates :username, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
