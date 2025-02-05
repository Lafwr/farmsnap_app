class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :farmer, dependent: :destroy
  # validates :role, presence: true (Unless commented out, used needs a role before being able to create an account)
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  ROLES = %w[customer farmer admin].freeze

  # LIKES AND COMMENTS FOR POSTS
  has_many :likes, dependent: :destroy
  # has_many :comments, dependent: :destroy

  # Role helper methods
  def customer?
    role == "standard"
  end

  def farmer?
    role == "farmer"
  end
end
