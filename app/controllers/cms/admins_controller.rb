class Cms::AdminsController < CmsController
  before_action "authenticateSuper!", except: ['edit','update']

  def index
    @admins = Admin.where.not(id: current_admin.id).order('name').paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)

    # Check current admin has entered their correct password 
    reAuth = reAuthCurrentAdmin(params['admin']['current_admin_pass'])

    if reAuth && @admin.save
      flash[:notice] = "Successfully created Admin." 
      redirect_to cms_admins_path
    else
      flash[:alert] = "You need to enter your current password to make changes." unless reAuth
      render :action => 'new'
    end
  end

  def edit
    @admin = Admin.find(params[:id])
    authenticateSuper! unless current_admin.id == @admin.id 
  end

  def update
    @admin = Admin.find(params[:id])
    # Only allow sudo admins to edit other admins.
    authenticateSuper! unless current_admin.id == @admin.id 

    # Check current admin has entered their correct password 
    reAuth = reAuthCurrentAdmin(params['admin']['current_admin_pass'])
    
    # Filter password parameters of not set
    params[:admin].delete(:password) if params[:admin][:password].blank?
    params[:admin].delete(:password_confirmation) if params[:admin][:password].blank? and params[:admin][:password_confirmation].blank?
    
    if reAuth && @admin.update_attributes(admin_params)
      flash[:notice] = "Successfully updated Admin."
      redirect_to edit_cms_admin_path
    else
      flash[:alert] = "You need to enter your current password to make changes." unless reAuth
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
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, ( :sudo if current_admin.sudo) )
  end

end
