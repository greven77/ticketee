class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :state
  validates :title, :presence => true
  validates :description, :presence => true, :length => { :minimum => 10 }
  has_many :assets
  accepts_nested_attributes_for :assets
  attr_accessible :description, :title, :assets_attributes

  has_many :comments
end
