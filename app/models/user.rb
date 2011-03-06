class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable, :confirmable,

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :trained

  has_many :messages
  accepts_nested_attributes_for :messages, :reject_if => :all_blank
  #serialize :classifier, Classifier::Bayes
  after_create :initialize_classifier#, :training
  before_update :remove_stemmer

  def training
      self.classifier.categories.each do |cat|
        c = Category.find_by_title(cat.downcase)
        mes = c.messages.find(:all, :conditions => {:train => true})
        tr = []
        mes.each {|m| tr << m.body + ' ' + m.subject.title + ' ' + m.address.from + ' ' + m.address.organization.title}
        tr.each {|tra| self.classifier.train(cat, tra) }
        end
        self.update_attribute(:trained, true)


  end

private
  def initialize_classifier
  @cats = []
  Category.all.each {|c| @cats << c.title}
    self.classifier = Classifier::Bayes.new :categories => @cats
    self.update_attribute(:trained, false)
    remove_stemmer
  end



  def remove_stemmer
    self.classifier.remove_stemmer
  end

end

