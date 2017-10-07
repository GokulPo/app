class Company < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tasks
  attr_accessor :com_name
has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100" }, :default_url => "/assets/:style/missing1.png"

validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

validates_presence_of :name
validates_uniqueness_of :name
validates_presence_of :maxcount

end
