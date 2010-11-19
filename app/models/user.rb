class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def admined_groups
    #TODO: IT'S HORRIBLE
    return memberships.where(:admin => true).map {|t| t.group}
  end
end
