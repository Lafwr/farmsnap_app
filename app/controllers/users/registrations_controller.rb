class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    if current_user.role == "farmer"
      Farmer.new
      new_farmer_path
    else
      root_path
    end
  end

end
