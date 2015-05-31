class Cms::AdminsController < CmsController
#class AdminsController < ApplicationController
   #load_and_authorize_resource

    def index
      @admins = Admin.all #excludes(:id => current_admin.id)
      #@admins = Admin.where.not(id: current_admin.id)
    end

    def new
      @admin = Admin.new
    end

    def create
      @admin = Admin.new(admin_params)
      if @admin.save
        flash[:notice] = "Successfully created Admin." 
        redirect_to cms_admins_path
      else
        render :action => 'new'
      end
    end

    def edit
      @admin = Admin.find(params[:id])
    end

    def update
      @admin = Admin.find(params[:id])
      params[:admin].delete(:password) if params[:admin][:password].blank?
      params[:admin].delete(:password_confirmation) if params[:admin][:password].blank? and params[:admin][:password_confirmation].blank?
      if @admin.update_attributes(admin_params)
        flash[:notice] = "Successfully updated Admin."
        redirect_to cms_admins_path
      else
        render :action => 'edit'
      end
    end

    def destroy
      @admin = Admin.find(params[:id])
      if @admin.destroy
        flash[:notice] = "Successfully deleted Admin."
        redirect_to cms_admins_path
      end
    end 

private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :encrypted_password)
  end

end
