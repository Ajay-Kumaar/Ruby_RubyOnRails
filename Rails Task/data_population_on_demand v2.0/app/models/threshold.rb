class Threshold < ApplicationRecord
  def self.set_threshold threshold_value
    Threshold.create(threshold: threshold_value)
  end
  def self.get_threshold_value
    Threshold.first.threshold
  end
end