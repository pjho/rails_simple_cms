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
    if @admin.save
      flash[:notice] = "Successfully created Admin." 
      redirect_to cms_admins_path
    else
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
    authCurrentAdmin = Admin.find(current_admin.id).valid_password?(params['admin']['current_admin_pass'])
    
    Rails.logger.debug("Admin: #{authCurrentAdmin.inspect}")

    params[:admin].delete(:password) if params[:admin][:password].blank?
    params[:admin].delete(:password_confirmation) if params[:admin][:password].blank? and params[:admin][:password_confirmation].blank?
    
    if !authCurrentAdmin
      flash[:alert] = "You need to enter your current password to make changes."
      render :action => 'edit'
    elsif @admin.update_attributes(admin_params)
      flash[:notice] = "Successfully updated Admin."
      redirect_to edit_cms_admin_path
    else
      render :action => 'edit'
    end
  end

  # def updateasdsadsad
  #  @user = User.find(params[:id])
  #  user = User.find_by_email(current_user.email).try(:authenticate, params[:current_admin_pass])
  #   if user && @user.update_attributes(params[:user])
  #     flash[:success] = "Profile updated"
  #     sign_in @user
  #     redirect_to @user
  #   else
  #     flash.now[:error] = "Incorrect Current Password" unless user
  #     sign_in @user
  #     render 'edit'
  #   end
  # end





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
