class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def populate
    count = params[:count].to_i
    UsersController.check_to_populate(count)
    if ((JidPool.where(is_used: false).count - count) < 50)
      unused_jids = JidPool.generate_unused_jids(50 - (JidPool.where(is_used: false).count - count) )
      unused_jids.each do |jid|
        JidPool.create(jid: jid, is_used: false)
      end
    end
    count.times do
      jid = JidPool.where(is_used: false).first.jid
      User.create(email: User.generate_random_email, jid: jid)
      JidPool.where(jid: jid).update(is_used: true)
    end
    redirect_to users_path
  end
  def UsersController.check_to_populate count
    unused_jids_count = JidPool.where(is_used: false).count
    if unused_jids_count == 0
      unused_jids = JidPool.generate_unused_jids(count)
      unused_jids.each do |jid|
        JidPool.create(jid: jid, is_used: false)
      end
    elsif ((unused_jids_count - count) < 50)
      unused_jids = JidPool.generate_unused_jids(50 - (unused_jids_count - count))
      unused_jids.each do |jid|
        JidPool.create(jid: jid, is_used: false)
      end
    end
  end
end