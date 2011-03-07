class Subject < ActiveRecord::Base
  has_many :messages
  attr_accessible :title




end

