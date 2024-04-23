class JidPoolsController < ApplicationController

  def index
  end

  def threshold
    if params[:count] == ""
      render plain: "Threshold value can't be empty."
    else
      Threshold.set_threshold(params[:count].to_i)
    end
  end

  def populate
    threshold_value = Threshold.get_threshold
    if threshold_value == nil
      render plain: "Please set threshold value first."
    else
      count_of_unused_jids_created = JidPool.generate_unused_jids(threshold_value)
      if count_of_unused_jids_created == 0
        render plain: "Enough jids already available."
      end
    end
  end

end