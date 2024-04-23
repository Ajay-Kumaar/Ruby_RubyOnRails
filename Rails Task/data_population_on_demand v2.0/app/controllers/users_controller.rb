class UsersController < ApplicationController

  def index
  end

  def manual_user_addition
    if JidPool.check_unused_jids_count == "failure"
      render plain: "Please set the threshold value if not already set / Please populate the jids as the unused jids count is less than the threshold"
    end
  end

  def bulk_user_addition
    if JidPool.check_unused_jids_count == "failure"
      render plain: "Please set the threshold value if not already set / Please populate the jids as the unused jids count is less than the threshold "
    end
  end

  def show_users
    @users = User.all
  end

  def process_manual_user_addition
    jid = JidPool.where(is_used: false).first.jid    
    user = User.create(jid: jid, name: params[:name], email: params[:email], phone_number: params[:phone_number], address: params[:address])
    if user.valid?
      JidPool.where(jid: jid).update(is_used: true)
    else
      message = ""
      for str in user.errors.full_messages
        message += str + "\n"
      end
      render plain: message, status: :not_acceptable
    end
  end

  def process_bulk_user_addition
    if params[:count] == ""
      render plain: "Count value can't be empty."
    else
      process_status = User.process_bulk_user_details(params[:count].to_i)
      if process_status == "failure"
        render plain: "Not enough jids available / Count of unused jids less than the threshold. Please populate jids first."
      end
    end
  end

  def delete_user_details
    @user = User.find(params[:id])
    @user.destroy
    redirect_to jid_pools_path
  end

  def edit_user_details
    @user = User.find(params[:id])
  end

  def process_edit_user_details
    @user = User.find(params[:id])
    if @user.update(user_params)
      render plain: "User details updated successfully."
    else
      render 'edit_user_details'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :address)
  end

end