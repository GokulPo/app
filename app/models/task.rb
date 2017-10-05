class Task < ApplicationRecord
  attr_accessor :day, :hour, :minute, :exp
  has_one :companies

  validates :name, :presence => true

end
