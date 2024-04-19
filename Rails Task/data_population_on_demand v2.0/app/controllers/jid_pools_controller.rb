class JidPoolsController < ApplicationController
  def index
  end

  def threshold
    threshold_value = params[:count].to_i
    Threshold.set_threshold(threshold_value)
    #puts "\n\nThreshold: #{threshold_value}\n\n"
  end

  def populate
    threshold_value = Threshold.get_threshold
    JidPool.generate_unused_jids(threshold_value)
  end
end