class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :role
  has_and_belongs_to_many :companies
  has_many :task, :through => :companies

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" },:default_url => "/assets/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :phone
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :phone, format: { with: /\d{10}/}, :numericality => {:only_integer => true}

  def admin?
    if self.role_id == 1
      return true
    else
      return false
    end
  end
end
