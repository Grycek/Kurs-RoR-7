class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_filter :authenticate_admin!, :only => [:invite]
  #cos do zapraszania
  
  def index
      @groups = Group.all
  end
  
  def new
      @group = Group.new
  end
  
  def create
      @group = Group.create(params[:group])

      if @group.save
          @membership = @group.memberships.create(:user_id => current_user.id, :admin => true)
          if @membership.save
              redirect_to groups_path
          else
              @group.delete
              render :action => :new
          end
      else
          render :action => :new
      end
  end

  
  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @invitation = MembershipInvitation.new
    @uninvited_users = User.all.find_all {|u| !@group.is_invited(u) and !@group.is_member(u)}
  end

  
  def invite
      @group = Group.find(params[:id])
      @invitation = MembershipInvitation.new(params[:membership_invitation])
      #@invitation = MembershipInvitation.new(:user_id => 1, :group_id => @group.id)
      @invitation.update_attributes(:group_id => @group.id)
      #@invitation.update_attributes(:group_id => 1)
      if @invitation.save
          redirect_to groups_path
      else
          render :action => :show
      end
  end
  
  
  
  def authenticate_admin!
      @group = Group.find(params[:id])
      if !@group.is_admin(current_user)
          redirect_to groups_path
      end
  end
end
