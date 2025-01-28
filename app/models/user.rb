class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :farmer, dependent: :destroy
  # validates :role, presence: true (Unless commented out, used needs a role before being able to create an account)


  ROLES = %w[customer farmer admin].freeze

  # Role helper methods
  def customer?
    role == "standard"
  end

  def farmer?
    role == "farmer"
  end
end
