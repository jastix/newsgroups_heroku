class Subject < ActiveRecord::Base
  has_many :messages
  attr_accessible :title

  searchable do
    text :title
  end

end

