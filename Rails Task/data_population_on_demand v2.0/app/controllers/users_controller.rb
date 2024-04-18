class UsersController < ApplicationController
  def index
  end

  def manual_user_addition
  end

  def bulk_user_addition
  end

  def show_users
  end

  def process_manual_user_addition
    #create self.methods in user model class that will perform database operations
    redirect_to users_path
  end
end