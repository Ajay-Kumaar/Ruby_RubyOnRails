class JidPoolsController < ApplicationController
  def index
    @unused_jids_count = JidPool.where(is_used: false).count
  end
  def populate
    count = params[:count].to_i
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
    redirect_to jid_pools_path
  end
end