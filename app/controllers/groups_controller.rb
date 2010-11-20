class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
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
  end
end
