class Group < ActiveRecord::Base
  validates :description, :presence => true
  
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  
  def admins
    #TODO: IT'S HORRIBLE
    return memberships.where(:admin => true).map {|t| t.user}
  end
  
  def is_admin(user)
      return admins().include?(user)
  end
end
