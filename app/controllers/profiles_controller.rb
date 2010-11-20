class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_profile_inv!, :only => [:invite]
  
  def index
      @users       = User.all
  end
  
  def show
      @user        = User.find(params[:id])
      @groups      = @user.groups
      @membership  = Membership.new
      if  @user == current_user
        @invitations = @user.membership_invitations
      else
        @invitations = []
      end
  end

  
  #authenticate
  def invite
      @user        = User.find(params[:id])
      @groups      = @user.groups
      if  @user == current_user
        @invitations = @user.membership_invitations
      else
        @invitations = []
      end
      
      inv          = MembershipInvitation.find(params[:inv])
      @membership  = current_user.memberships.new(:group_id => inv.group_id)
      
      inv.delete
      @membership.save if params[:membership][:accept] == "1"
      render :action => :show

  end
  
  
  def authenticate_profile_inv!
      @user        = User.find(params[:id])
      if @user != current_user
          redirect_to root_path
      end
  end
  
end
