class Subject < ActiveRecord::Base
  has_many :messages
  attr_accessible :title


define_index do
  indexes title
end

end

