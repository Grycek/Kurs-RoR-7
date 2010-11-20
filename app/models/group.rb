class Group < ActiveRecord::Base
  validates :description, :presence => true
  
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  
  has_many :membership_invitations, :dependent => :destroy
  
  def admins
    #TODO: IT'S HORRIBLE
    return memberships.where(:admin => true).map {|t| t.user}
  end
  
  def is_admin(user)
      return admins().include?(user)
  end
  
  def is_member(user)
      return users.include?(user)
  end
  
  def is_invited(user)
      return (membership_invitations.map {|t| t.user_id}).include?(user.id)
  end
end
