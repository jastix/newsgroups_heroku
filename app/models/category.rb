class Category < ActiveRecord::Base
  has_many :messages
  attr_accessible :title, :assigned



  accepts_nested_attributes_for :messages, :reject_if => :all_blank




end

