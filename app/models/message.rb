class Message < ActiveRecord::Base
  belongs_to :address
  belongs_to :subject
  belongs_to :category
  belongs_to :user
  attr_accessible :body, :train, :address_id, :category_id, :subject_id, :user_id, :assigned_category
  accepts_nested_attributes_for :category, :reject_if => :all_blank
  #after_commit :classify




  def classify
    if self.user.trained == true
      if self.train == false
        tr = ""
        tr << self.body + ' ' + self.subject.title + ' ' + self.address.from + ' ' + self.address.organization.title
        assig = self.user.classifier.classify tr
        self.update_attribute(:assigned_category, assig)
      end
    end
  end

    searchable do
    text :body, :stored => true do |mes|
      mes.body + mes.address.from + mes.subject.title + mes.address.organization.title
    end
    text :title, :stored => true do |t|
      t.subject.title + ' ' + t.address.organization.title
    end
  end





end

