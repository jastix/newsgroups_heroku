class Address < ActiveRecord::Base
  belongs_to :organization
  has_many :messages
  attr_accessible :from, :organization_id
  validates_presence_of :organization_id
  validates_presence_of :from



end
