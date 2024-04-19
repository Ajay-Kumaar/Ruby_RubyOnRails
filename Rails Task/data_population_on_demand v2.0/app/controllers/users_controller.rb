class UsersController < ApplicationController
  def index
  end

  def manual_user_addition
  end

  def bulk_user_addition
  end

  def show_users
    @users = process_show_users
  end

  def process_manual_user_addition
    #create self.methods in user model class that will perform database operations
    user_details = []
    user_details[0] = nil
    user_details[1] = params[:name]
    user_details[2] = params[:email]
    user_details[3] = params[:phone_number]
    user_details[4] = params[:address]
    User.process_manual_user_details(user_details)
  end

  def process_bulk_user_addition
    User.process_bulk_user_details(params[:count].to_i)
  end

  def process_show_users
    User.process_show_user_details
  end
end